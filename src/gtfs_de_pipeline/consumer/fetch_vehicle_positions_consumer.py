import json
import time
from confluent_kafka import Consumer
from pyiceberg.catalog.sql import SqlCatalog
import pyarrow as pa


# Kafka Consumer 
consumer = Consumer({
	'bootstrap.servers': 'localhost:9092',
	'group.id' : 'bronze-ingestion-consumer',
	'auto.offset.reset': 'earliest',
	})

consumer.subscribe(['nyc_transit.public.vehicle_current_state'])


# Iceberg Catalog
warehouse_path = "/home/reterro/evan/Project/gtfs-de-pipeline"
catalog = SqlCatalog(
 	"bronze_catalog",
 	**{
 		"uri" : f"sqlite:///{warehouse_path}/iceberg_catalog/catalog.db",
 		"warehouse" : f"file://{warehouse_path}/iceberg_catalog/warehouse",
 	})


table = catalog.load_table("bronze.vehicle_positions")


buffer = []
batch_size = 100
flush_interval_time = 10
last_flush_time  = time.time()


def flush(buffer):
	if not buffer:
		return
	arrow_table = pa.Table.from_pylist(buffer,schema = table.schema().as_arrow())
	table.append(arrow_table)
	print(f"Flushed {len(buffer)} rows to bronze!")


if __name__ == "__main__":

	try:
		while True:
			message = consumer.poll(timeout=1.0)

			if message is None:
				continue
			elif message.error():
				continue
			else:
				event = json.loads(message.value())
				payload = event['payload']

				if payload['after'] is None:
					continue
				row = payload['after']
				row['op'] = payload['op']
				buffer.append(row)

				time_since_flush = time.time() - last_flush_time

				if len(buffer)>=batch_size or time_since_flush>=flush_interval_time:
					flush(buffer)
					buffer = []
					last_flush_time = time.time()

	except KeyboardInterrupt:
		print("Shutting Down, Flush remaining buffer")
		flush(buffer)
		buffer = []
		last_flush_time = time.time()
	finally:
		consumer.close()