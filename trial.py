from google.transit import gtfs_realtime_pb2

feed = gtfs_realtime_pb2.FeedMessage()
with open("response.pb", "rb") as f:
    feed.ParseFromString(f.read())

print(f"Feed timestamp: {feed.header.timestamp}")
print(f"Number of entities: {len(feed.entity)}")

for entity in feed.entity[:5]:
    vp = entity.vehicle
    print(
        f"vehicle_id={vp.vehicle.id}, "
        f"trip_id={vp.trip.trip_id}, "
        f"route_id={vp.trip.route_id}, "
        f"lat={vp.position.latitude}, "
        f"lon={vp.position.longitude}"
    )