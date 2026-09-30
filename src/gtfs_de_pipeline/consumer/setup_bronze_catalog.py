import os 
from dotenv import load_dotenv  

from pyiceberg.catalog.sql import SqlCatalog
from pyiceberg.schema import Schema
from pyiceberg.types import NestedField, StringType, DoubleType, TimestampType, IntegerType

# environment path
load_dotenv()
warehouse_path = os.getenv("ICEBERG_WAREHOUSE")


catalog = SqlCatalog(
 	"bronze_catalog",
 	**{
 		"uri" : f"sqlite:///{warehouse_path}/iceberg_catalog/catalog.db",
 		"warehouse" : f"file://{warehouse_path}/iceberg_catalog/warehouse",
 	})


bronze_vehicle_post_schema = Schema(
    NestedField(1, "vehicle_id", StringType(), required=True),
    NestedField(2, "trip_id", StringType(), required=True),
    NestedField(3, "route_id", StringType(), required=False),
    NestedField(4, "direction_id", IntegerType(), required=False),
    NestedField(5, "stop_id", StringType(), required=False),
    NestedField(6, "lat", DoubleType(), required=False),
    NestedField(7, "lon", DoubleType(), required=False),
    NestedField(8, "bearing", DoubleType(), required=False),
    NestedField(9, "occupancy_status", IntegerType(), required=False),
    NestedField(10, "last_updated_at", TimestampType(), required=False),
    NestedField(11, "op", StringType(), required=False),
)


bronze_trip_update_schema = Schema(
    NestedField(1, "trip_id", StringType(), required=True),
    NestedField(2, "stop_id", StringType(), required=True),
    NestedField(3, "route_id", StringType(), required=True),
    NestedField(4, "vehicle_id", StringType(), required=True),
    NestedField(5, "stop_sequence", IntegerType(), required=False),
    NestedField(6, "arrival_time", TimestampType(), required=False),
    NestedField(7, "departure_time", TimestampType(), required=False),
    NestedField(8, "delay", IntegerType(), required=False),
    NestedField(9, "last_updated_at", TimestampType(), required=False),
    NestedField(10, "op", StringType(), required=False),
);

catalog.create_namespace("bronze")
catalog.create_table("bronze.vehicle_positions", schema =bronze_vehicle_post_schema)
catalog.create_table("bronze.trip_updates", schema = bronze_trip_update_schema)
print("Bronze Table Created!")
