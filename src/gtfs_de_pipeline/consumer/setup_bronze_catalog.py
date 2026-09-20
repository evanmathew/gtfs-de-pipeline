from pyiceberg.catalog.sql import SqlCatalog
from pyiceberg.schema import Schema
from pyiceberg.types import NestedField, StringType, DoubleType, TimestampType

warehouse_path = "/home/reterro/evan/Project/gtfs-de-pipeline"
catalog = SqlCatalog(
 	"bronze_catalog",
 	**{
 		"uri" : f"sqlite:///{warehouse_path}/iceberg_catalog/catalog.db",
 		"warehouse" : f"file://{warehouse_path}/iceberg_catalog/warehouse",
 	})


bronze_schema = Schema(
    NestedField(1, "vehicle_id", StringType(), required=True),
    NestedField(2, "trip_id", StringType(), required=True),
    NestedField(3, "route_id", StringType(), required=False),
    NestedField(4, "lat", DoubleType(), required=False),
    NestedField(5, "lon", DoubleType(), required=False),
    NestedField(6, "speed", DoubleType(), required=False),
    NestedField(7, "bearing", DoubleType(), required=False),
    NestedField(8, "last_updated_at", TimestampType(), required=False),
    NestedField(9, "op", StringType(), required=False),
)


catalog.create_namespace("bronze")
catalog.create_table("bronze.vehicle_positions", schema =bronze_schema)
print("Bronze Table Created!")