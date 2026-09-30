import os
from dotenv import load_dotenv
import duckdb

load_dotenv()
duckdb_warehouse_path = os.getenv("DUCKDB_WAREHOUSE_PATH") 
database_name = os.getenv("POSTGRES_DB")
database_user = os.getenv("POSTGRES_USER")
database_pass = os.getenv("POSTGRES_PASSWORD")
database_host = os.getenv("POSTGRES_HOST")
database_port = os.getenv("POSTGRES_PORT")


con = duckdb.connect(f"{duckdb_warehouse_path}")
print(f"Connecting to: {duckdb_warehouse_path}")
con.execute("INSTALL postgres; LOAD postgres;")
con.execute(f"""
    ATTACH 'dbname={database_name} host={database_host} port={database_port} user={database_user} password={database_pass}'
    AS pg (TYPE postgres);
""")

static_tables = ["agency", "routes", "stops", "trips", "calendar", "calendar_dates", "stop_times"]

for tbl in static_tables:
    con.execute(f"CREATE OR REPLACE TABLE bronze_{tbl} AS SELECT * FROM pg.{tbl};")
    count = con.execute(f"SELECT count(*) FROM bronze_{tbl}").fetchone()[0]
    print(f"bronze_{tbl}: {count} rows")

con.close()