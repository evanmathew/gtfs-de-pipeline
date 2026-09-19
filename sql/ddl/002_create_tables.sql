\c nyc_transit_oltp


--CREATE ROLE transit_app WITH LOGIN PASSWORD 'transit_pass_4321';
--GRANT CONNECT ON DATABASE nyc_transit_oltp TO transit_app;
--GRANT USAGE, CREATE ON SCHEMA public TO transit_app;


CREATE TABLE IF NOT EXISTS agency(
	agency_id VARCHAR PRIMARY KEY,
	agency_name VARCHAR NOT NULL,
	agency_url TEXT,
	agency_timezone VARCHAR,
	agency_lang VARCHAR,
	agency_phone VARCHAR
	);

CREATE TABLE IF NOT EXISTS calendar(
	service_id VARCHAR PRIMARY KEY,
	monday INTEGER,
	tuesday INTEGER,
	wednesday INTEGER,
	thursday INTEGER,
	friday INTEGER,
	saturday INTEGER,
	sunday INTEGER,
	start_date DATE,
	end_date DATE
	);

CREATE TABLE IF NOT EXISTS calendar_dates(
	service_id VARCHAR REFERENCES calendar(service_id),
	date DATE,
	exception_type INTEGER,
	PRIMARY KEY (service_id, date)
	);

CREATE TABLE IF NOT EXISTS routes(
	route_id VARCHAR PRIMARY KEY,
	agency_id VARCHAR REFERENCES agency(agency_id),
	route_short_name VARCHAR,
	route_long_name TEXT,
	route_desc TEXT,
	route_type INTEGER,
	route_color VARCHAR,
	route_text_color VARCHAR
	);

CREATE TABLE IF NOT EXISTS stops(
	stop_id VARCHAR PRIMARY KEY,
	stop_name VARCHAR,
	stop_desc TEXT,
	stop_lat NUMERIC(9,6),
	stop_lon NUMERIC(9,6),
	zone_id VARCHAR,
	stop_url VARCHAR,
	location_type VARCHAR,
	parent_station VARCHAR
	);

CREATE TABLE IF NOT EXISTS trips(
	route_id VARCHAR REFERENCES routes(route_id),
	service_id VARCHAR REFERENCES calendar(service_id),
	trip_id VARCHAR PRIMARY KEY,
	trip_headsign VARCHAR,
	direction_id INTEGER,
	block_id VARCHAR,
	shape_id VARCHAR
	);

CREATE TABLE IF NOT EXISTS stop_times(
	trip_id VARCHAR REFERENCES trips(trip_id),
	stop_id VARCHAR REFERENCES stops(stop_id),
	arrival_time VARCHAR,   -- GTFS times can exceed 24:00:00, so not a native TIME type
	departure_time VARCHAR,
	stop_sequence INTEGER,
	pickup_type INTEGER,
	drop_off_type INTEGER,
	timepoint INTEGER,
	PRIMARY KEY (trip_id, stop_sequence)
	);

-- Operational side: fed by the realtime poller, no FK constraints
-- (live feed may reference trip_id/route_id not yet in static schedule)
CREATE TABLE IF NOT EXISTS vehicle_current_state(
	vehicle_id VARCHAR,
	trip_id VARCHAR,
	route_id VARCHAR,
	lat NUMERIC(9,6),
	lon NUMERIC(9,6),
	speed NUMERIC(5,2),
	bearing NUMERIC(5,2),
	last_updated_at TIMESTAMP,
	PRIMARY KEY (vehicle_id, trip_id)
	);

-- Table-level grants -- must come after tables exist, or transit_app
-- still can't read/write any rows despite the schema-level grant above
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO transit_app;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO transit_app;