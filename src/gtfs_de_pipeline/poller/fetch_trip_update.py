import requests
import time
from datetime import datetime, timezone
from google.transit import gtfs_realtime_pb2
import psycopg2
from psycopg2.extras import execute_values
import os
from dotenv import load_dotenv


def fetch_vehicle_positions(api_key):
    response = requests.get(f"https://gtfsrt.prod.obanyc.com/tripUpdates?key={api_key}")
    if response.status_code != 200:
        raise Exception("API ERROR")

    feed = gtfs_realtime_pb2.FeedMessage()
    feed.ParseFromString(response.content)

    rows = []
    for entity in feed.entity:
        tu = entity.trip_update

        last_updated_at = datetime.fromtimestamp(feed.header.timestamp, tz=timezone.utc)
        # btw this attribute is in timezone datatype in postgres and poller datatype is in integer so im converting before appending, thanks !

        for stu in tu.stop_time_update:
            rows.append(
                (
                    tu.trip.trip_id,
                    stu.stop_id,
                    tu.trip.route_id,
                    tu.vehicle.id,
                    stu.stop_sequence,
                    datetime.fromtimestamp(stu.arrival.time, tz=timezone.utc)
                    if stu.arrival.time else None,
                    datetime.fromtimestamp(stu.departure.time, tz=timezone.utc)
                    if stu.departure.time else None,
                    tu.delay,
                    last_updated_at,
                )
            )

    return rows



def deduplicate_rows(rows):
    deduped = {}
    for row in rows:
        trip_id, stop_id = row[0], row[1]
        deduped[(trip_id, stop_id)] = row
    return list(deduped.values())


def value_upsert(conn, values):
    sql = """
	        INSERT INTO trip_update_current_state
	            (trip_id, stop_id, route_id, vehicle_id, stop_sequence, arrival_time, departure_time, delay, last_updated_at)
	        VALUES %s
	        ON CONFLICT (trip_id, stop_id)
	        DO UPDATE SET
	            route_id = EXCLUDED.route_id,
	            stop_sequence = EXCLUDED.stop_sequence,
	            arrival_time = EXCLUDED.arrival_time,
	            departure_time = EXCLUDED.departure_time,
                delay = EXCLUDED.delay,
	            last_updated_at = EXCLUDED.last_updated_at
    	"""
    with conn.cursor() as cursor:
        execute_values(cursor, sql, values)

    conn.commit()


if __name__ == "__main__":

    load_dotenv()

    api_key = os.getenv("GTFS_API_KEY")

    conn = psycopg2.connect(
        host=os.getenv("POSTGRES_HOST"),
        port=os.getenv("POSTGRES_PORT"),
        database=os.getenv("POSTGRES_DB"),
        user=os.getenv("POSTGRES_USER"),
        password=os.getenv("POSTGRES_PASSWORD"),
    )

    while True:

        try:

            start_time = time.time()

            rows = fetch_vehicle_positions(api_key)
            rows = deduplicate_rows(rows)
            print(f"Fetched{len(rows)} Vehicle Positions")

            value_upsert(conn, rows)

            elapsed_time = time.time() - start_time
            sleep_time = max(0, 20 - elapsed_time)

            time.sleep(sleep_time)

        except Exception as e:
            print(f"Polling Error: {e}")
            conn.rollback()
            time.sleep(5)
