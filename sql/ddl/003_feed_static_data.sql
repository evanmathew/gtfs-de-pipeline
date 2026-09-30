\c nyc_transit_oltp
-- ================================================
-- Replace path_to_project with your project path !
-- ================================================

-- ============ Bronx ============
\copy agency FROM 'path_to_project/sql/ddl/static_data/gtfs_bx/agency.txt' WITH (FORMAT csv, HEADER true);
\copy calendar FROM 'path_to_project/sql/ddl/static_data/gtfs_bx/calendar.txt' WITH (FORMAT csv, HEADER true);
\copy calendar_dates FROM 'path_to_project/sql/ddl/static_data/gtfs_bx/calendar_dates.txt' WITH (FORMAT csv, HEADER true);
\copy routes FROM 'path_to_project/sql/ddl/static_data/gtfs_bx/routes.txt' WITH (FORMAT csv, HEADER true);
\copy stops FROM 'path_to_project/sql/ddl/static_data/gtfs_bx/stops.txt' WITH (FORMAT csv, HEADER true);
\copy trips FROM 'path_to_project/sql/ddl/static_data/gtfs_bx/trips.txt' WITH (FORMAT csv, HEADER true);
\copy stop_times(trip_id, arrival_time, departure_time, stop_id, stop_sequence, pickup_type, drop_off_type, timepoint) FROM 'path_to_project/sql/ddl/static_data/gtfs_bx/stop_times.txt' WITH (FORMAT csv, HEADER true);

-- ============ Queens ============
\copy agency FROM 'path_to_project/sql/ddl/static_data/gtfs_q/agency.txt' WITH (FORMAT csv, HEADER true);
\copy calendar FROM 'path_to_project/sql/ddl/static_data/gtfs_q/calendar.txt' WITH (FORMAT csv, HEADER true);
\copy calendar_dates FROM 'path_to_project/sql/ddl/static_data/gtfs_q/calendar_dates.txt' WITH (FORMAT csv, HEADER true);
\copy routes FROM 'path_to_project/sql/ddl/static_data/gtfs_q/routes.txt' WITH (FORMAT csv, HEADER true);
\copy stops FROM 'path_to_project/sql/ddl/static_data/gtfs_q/stops.txt' WITH (FORMAT csv, HEADER true);
\copy trips FROM 'path_to_project/sql/ddl/static_data/gtfs_q/trips.txt' WITH (FORMAT csv, HEADER true);
\copy stop_times(trip_id, arrival_time, departure_time, stop_id, stop_sequence, pickup_type, drop_off_type, timepoint) FROM 'path_to_project/sql/ddl/static_data/gtfs_q/stop_times.txt' WITH (FORMAT csv, HEADER true);

-- ============ MTA Bus Company ============
\copy agency FROM 'path_to_project/sql/ddl/static_data/gtfs_busco/agency.txt' WITH (FORMAT csv, HEADER true);
\copy calendar FROM 'path_to_project/sql/ddl/static_data/gtfs_busco/calendar.txt' WITH (FORMAT csv, HEADER true);
\copy calendar_dates FROM 'path_to_project/sql/ddl/static_data/gtfs_busco/calendar_dates.txt' WITH (FORMAT csv, HEADER true);
\copy routes FROM 'path_to_project/sql/ddl/static_data/gtfs_busco/routes.txt' WITH (FORMAT csv, HEADER true);
\copy stops FROM 'path_to_project/sql/ddl/static_data/gtfs_busco/stops.txt' WITH (FORMAT csv, HEADER true);
\copy trips FROM 'path_to_project/sql/ddl/static_data/gtfs_busco/trips.txt' WITH (FORMAT csv, HEADER true);
\copy stop_times(trip_id, arrival_time, departure_time, stop_id, stop_sequence, pickup_type, drop_off_type, timepoint) FROM 'path_to_project/sql/ddl/static_data/gtfs_busco/stop_times.txt' WITH (FORMAT csv, HEADER true);

-- ============ Brooklyn ============
\copy agency FROM 'path_to_project/sql/ddl/static_data/gtfs_b/agency.txt' WITH (FORMAT csv, HEADER true);
\copy calendar FROM 'path_to_project/sql/ddl/static_data/gtfs_b/calendar.txt' WITH (FORMAT csv, HEADER true);
\copy calendar_dates FROM 'path_to_project/sql/ddl/static_data/gtfs_b/calendar_dates.txt' WITH (FORMAT csv, HEADER true);
\copy routes FROM 'path_to_project/sql/ddl/static_data/gtfs_b/routes.txt' WITH (FORMAT csv, HEADER true);
\copy stops FROM 'path_to_project/sql/ddl/static_data/gtfs_b/stops.txt' WITH (FORMAT csv, HEADER true);
\copy trips FROM 'path_to_project/sql/ddl/static_data/gtfs_b/trips.txt' WITH (FORMAT csv, HEADER true);
\copy stop_times(trip_id, arrival_time, departure_time, stop_id, stop_sequence, pickup_type, drop_off_type, timepoint) FROM 'path_to_project/sql/ddl/static_data/gtfs_b/stop_times.txt' WITH (FORMAT csv, HEADER true);

-- ============ Staten Island ============
\copy agency FROM 'path_to_project/sql/ddl/static_data/gtfs_si/agency.txt' WITH (FORMAT csv, HEADER true);
\copy calendar FROM 'path_to_project/sql/ddl/static_data/gtfs_si/calendar.txt' WITH (FORMAT csv, HEADER true);
\copy calendar_dates FROM 'path_to_project/sql/ddl/static_data/gtfs_si/calendar_dates.txt' WITH (FORMAT csv, HEADER true);
\copy routes FROM 'path_to_project/sql/ddl/static_data/gtfs_si/routes.txt' WITH (FORMAT csv, HEADER true);
\copy stops FROM 'path_to_project/sql/ddl/static_data/gtfs_si/stops.txt' WITH (FORMAT csv, HEADER true);
\copy trips FROM 'path_to_project/sql/ddl/static_data/gtfs_si/trips.txt' WITH (FORMAT csv, HEADER true);
\copy stop_times(trip_id, arrival_time, departure_time, stop_id, stop_sequence, pickup_type, drop_off_type, timepoint) FROM 'path_to_project/sql/ddl/static_data/gtfs_si/stop_times.txt' WITH (FORMAT csv, HEADER true);

-- ============ Manhattan ============
\copy agency FROM 'path_to_project/sql/ddl/static_data/gtfs_m/agency.txt' WITH (FORMAT csv, HEADER true);
\copy calendar FROM 'path_to_project/sql/ddl/static_data/gtfs_m/calendar.txt' WITH (FORMAT csv, HEADER true);
\copy calendar_dates FROM 'path_to_project/sql/ddl/static_data/gtfs_m/calendar_dates.txt' WITH (FORMAT csv, HEADER true);
\copy routes FROM 'path_to_project/sql/ddl/static_data/gtfs_m/routes.txt' WITH (FORMAT csv, HEADER true);
\copy stops FROM 'path_to_project/sql/ddl/static_data/gtfs_m/stops.txt' WITH (FORMAT csv, HEADER true);
\copy trips FROM 'path_to_project/sql/ddl/static_data/gtfs_m/trips.txt' WITH (FORMAT csv, HEADER true);
\copy stop_times(trip_id, arrival_time, departure_time, stop_id, stop_sequence, pickup_type, drop_off_type, timepoint) FROM 'path_to_project/sql/ddl/static_data/gtfs_m/stop_times.txt' WITH (FORMAT csv, HEADER true);