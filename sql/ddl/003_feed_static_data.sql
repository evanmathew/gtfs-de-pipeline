\c nyc_transit_oltp

-- ============================================================
-- GTFS Static Data Loader
--
-- GTFS_BASE_DIR is supplied by psql:
--
-- psql -d nyc_transit_oltp \
--     -v GTFS_BASE_DIR="$PWD/sql/ddl/static_data" \
--     -f sql/ddl/003_feed_static_data.sql
--
-- Example:
-- GTFS_BASE_DIR/
-- ├── gtfs_bx/
-- ├── gtfs_q/
-- ├── gtfs_busco/
-- ├── gtfs_b/
-- ├── gtfs_si/
-- └── gtfs_m/
-- ============================================================


-- ============================================================
-- BX
-- ============================================================

\echo 'Loading GTFS BX...'

\copy agency FROM :'GTFS_BASE_DIR'/gtfs_bx/agency.txt WITH (FORMAT csv, HEADER true);
\copy calendar FROM :'GTFS_BASE_DIR'/gtfs_bx/calendar.txt WITH (FORMAT csv, HEADER true);
\copy calendar_dates FROM :'GTFS_BASE_DIR'/gtfs_bx/calendar_dates.txt WITH (FORMAT csv, HEADER true);
\copy routes FROM :'GTFS_BASE_DIR'/gtfs_bx/routes.txt WITH (FORMAT csv, HEADER true);
\copy stops FROM :'GTFS_BASE_DIR'/gtfs_bx/stops.txt WITH (FORMAT csv, HEADER true);
\copy trips FROM :'GTFS_BASE_DIR'/gtfs_bx/trips.txt WITH (FORMAT csv, HEADER true);

\copy stop_times(
    trip_id,
    arrival_time,
    departure_time,
    stop_id,
    stop_sequence,
    pickup_type,
    drop_off_type,
    timepoint
)
FROM :'GTFS_BASE_DIR'/gtfs_bx/stop_times.txt
WITH (FORMAT csv, HEADER true);


-- ============================================================
-- QUEENS
-- ============================================================

\echo 'Loading GTFS Q...'

\copy agency FROM :'GTFS_BASE_DIR'/gtfs_q/agency.txt WITH (FORMAT csv, HEADER true);
\copy calendar FROM :'GTFS_BASE_DIR'/gtfs_q/calendar.txt WITH (FORMAT csv, HEADER true);
\copy calendar_dates FROM :'GTFS_BASE_DIR'/gtfs_q/calendar_dates.txt WITH (FORMAT csv, HEADER true);
\copy routes FROM :'GTFS_BASE_DIR'/gtfs_q/routes.txt WITH (FORMAT csv, HEADER true);
\copy stops FROM :'GTFS_BASE_DIR'/gtfs_q/stops.txt WITH (FORMAT csv, HEADER true);
\copy trips FROM :'GTFS_BASE_DIR'/gtfs_q/trips.txt WITH (FORMAT csv, HEADER true);

\copy stop_times(
    trip_id,
    arrival_time,
    departure_time,
    stop_id,
    stop_sequence,
    pickup_type,
    drop_off_type,
    timepoint
)
FROM :'GTFS_BASE_DIR'/gtfs_q/stop_times.txt
WITH (FORMAT csv, HEADER true);


-- ============================================================
-- BUSCO
-- ============================================================

\echo 'Loading GTFS BUSCO...'

\copy agency FROM :'GTFS_BASE_DIR'/gtfs_busco/agency.txt WITH (FORMAT csv, HEADER true);
\copy calendar FROM :'GTFS_BASE_DIR'/gtfs_busco/calendar.txt WITH (FORMAT csv, HEADER true);
\copy calendar_dates FROM :'GTFS_BASE_DIR'/gtfs_busco/calendar_dates.txt WITH (FORMAT csv, HEADER true);
\copy routes FROM :'GTFS_BASE_DIR'/gtfs_busco/routes.txt WITH (FORMAT csv, HEADER true);
\copy stops FROM :'GTFS_BASE_DIR'/gtfs_busco/stops.txt WITH (FORMAT csv, HEADER true);
\copy trips FROM :'GTFS_BASE_DIR'/gtfs_busco/trips.txt WITH (FORMAT csv, HEADER true);

\copy stop_times(
    trip_id,
    arrival_time,
    departure_time,
    stop_id,
    stop_sequence,
    pickup_type,
    drop_off_type,
    timepoint
)
FROM :'GTFS_BASE_DIR'/gtfs_busco/stop_times.txt
WITH (FORMAT csv, HEADER true);


-- ============================================================
-- BROOKLYN
-- ============================================================

\echo 'Loading GTFS B...'

\copy agency FROM :'GTFS_BASE_DIR'/gtfs_b/agency.txt WITH (FORMAT csv, HEADER true);
\copy calendar FROM :'GTFS_BASE_DIR'/gtfs_b/calendar.txt WITH (FORMAT csv, HEADER true);
\copy calendar_dates FROM :'GTFS_BASE_DIR'/gtfs_b/calendar_dates.txt WITH (FORMAT csv, HEADER true);
\copy routes FROM :'GTFS_BASE_DIR'/gtfs_b/routes.txt WITH (FORMAT csv, HEADER true);
\copy stops FROM :'GTFS_BASE_DIR'/gtfs_b/stops.txt WITH (FORMAT csv, HEADER true);
\copy trips FROM :'GTFS_BASE_DIR'/gtfs_b/trips.txt WITH (FORMAT csv, HEADER true);

\copy stop_times(
    trip_id,
    arrival_time,
    departure_time,
    stop_id,
    stop_sequence,
    pickup_type,
    drop_off_type,
    timepoint
)
FROM :'GTFS_BASE_DIR'/gtfs_b/stop_times.txt
WITH (FORMAT csv, HEADER true);


-- ============================================================
-- STATEN ISLAND
-- ============================================================

\echo 'Loading GTFS SI...'

\copy agency FROM :'GTFS_BASE_DIR'/gtfs_si/agency.txt WITH (FORMAT csv, HEADER true);
\copy calendar FROM :'GTFS_BASE_DIR'/gtfs_si/calendar.txt WITH (FORMAT csv, HEADER true);
\copy calendar_dates FROM :'GTFS_BASE_DIR'/gtfs_si/calendar_dates.txt WITH (FORMAT csv, HEADER true);
\copy routes FROM :'GTFS_BASE_DIR'/gtfs_si/routes.txt WITH (FORMAT csv, HEADER true);
\copy stops FROM :'GTFS_BASE_DIR'/gtfs_si/stops.txt WITH (FORMAT csv, HEADER true);
\copy trips FROM :'GTFS_BASE_DIR'/gtfs_si/trips.txt WITH (FORMAT csv, HEADER true);

\copy stop_times(
    trip_id,
    arrival_time,
    departure_time,
    stop_id,
    stop_sequence,
    pickup_type,
    drop_off_type,
    timepoint
)
FROM :'GTFS_BASE_DIR'/gtfs_si/stop_times.txt
WITH (FORMAT csv, HEADER true);


-- ============================================================
-- MANHATTAN
-- ============================================================

\echo 'Loading GTFS M...'

\copy agency FROM :'GTFS_BASE_DIR'/gtfs_m/agency.txt WITH (FORMAT csv, HEADER true);
\copy calendar FROM :'GTFS_BASE_DIR'/gtfs_m/calendar.txt WITH (FORMAT csv, HEADER true);
\copy calendar_dates FROM :'GTFS_BASE_DIR'/gtfs_m/calendar_dates.txt WITH (FORMAT csv, HEADER true);
\copy routes FROM :'GTFS_BASE_DIR'/gtfs_m/routes.txt WITH (FORMAT csv, HEADER true);
\copy stops FROM :'GTFS_BASE_DIR'/gtfs_m/stops.txt WITH (FORMAT csv, HEADER true);
\copy trips FROM :'GTFS_BASE_DIR'/gtfs_m/trips.txt WITH (FORMAT csv, HEADER true);

\copy stop_times(
    trip_id,
    arrival_time,
    departure_time,
    stop_id,
    stop_sequence,
    pickup_type,
    drop_off_type,
    timepoint
)
FROM :'GTFS_BASE_DIR'/gtfs_m/stop_times.txt
WITH (FORMAT csv, HEADER true);


\echo '=========================================='
\echo 'GTFS static data loading completed!'
\echo '=========================================='
