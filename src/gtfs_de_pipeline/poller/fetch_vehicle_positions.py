import requests
import time
from datetime import datetime, timezone
from google.transit import gtfs_realtime_pb2
import psycopg2
from psycopg2.extras import execute_values
import os
from dotenv import load_dotenv

def fetch_vehicle_positions(api_key):
	response = requests.get(f"https://gtfsrt.prod.obanyc.com/vehiclePositions?key={api_key}")
	if response.status_code!=200:
		raise Exception("API ERROR")

	feed = gtfs_realtime_pb2.FeedMessage()
	feed.ParseFromString(response.content)

	row = []
	for entity in feed.entity:
		vp = entity.vehicle

		#btw this attribute is in timezone datatype in postgres and poller datatype is in integer so im converting before appending, thanks !
		last_updated_at = datetime.fromtimestamp(feed.header.timestamp, tz=timezone.utc) 

		row.append((
			vp.vehicle.id,
            vp.trip.trip_id,
            vp.trip.route_id,
            vp.position.latitude,
            vp.position.longitude,
            vp.position.speed,     # check: field may not always be populated
            vp.position.bearing,   # same caveat
            last_updated_at
			))
	return row

def value_upsert(conn,values):
	sql = """
			INSERT INTO vehicle_current_state
				(vehicle_id ,trip_id ,route_id ,lat ,lon ,speed ,bearing ,last_updated_at)
			VALUES %s
			ON CONFLICT (vehicle_id, trip_id) 
			DO UPDATE SET
				route_id = EXCLUDED.route_id,
				lat = EXCLUDED.lat,
				lon = EXCLUDED.lon,
				speed = EXCLUDED.speed,
				bearing = EXCLUDED.bearing,
				last_updated_at = EXCLUDED.last_updated_at
		"""



	with conn.cursor() as cursor:
		execute_values(cursor, sql, values)
	conn.commit()	




if __name__ =="__main__":

	load_dotenv()

 
	api_key = os.getenv("GTFS_API_KEY")

	conn = psycopg2.connect(
	    host=os.getenv("POSTGRES_HOST"),
	    port=os.getenv("POSTGRES_PORT"),
	    database=os.getenv("POSTGRES_DB"),
	    user=os.getenv("POSTGRES_USER"),
	    password=os.getenv("POSTGRES_PASSWORD")
	)

	while True:

		try:
			
			start_time = time.time()

			rows = fetch_vehicle_positions(api_key)
			print(f"Fetched{len(rows)} Vehicle Positions")
			
			value_upsert(conn, rows)

			elapsed_time = time.time() - start_time
			sleep_time = max(0, 30-elapsed_time)

			time.sleep(sleep_time)

		except Exception as e:
			print(f"Polling Error: {e}")
			time.sleep(5)
