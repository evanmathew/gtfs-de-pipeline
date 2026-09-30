
CREATE DATABASE nyc_transit_oltp;
 
CREATE ROLE transit_app WITH LOGIN PASSWORD 'transit_pass_4321';
GRANT CONNECT ON DATABASE nyc_transit_oltp TO transit_app;
GRANT USAGE, CREATE ON SCHEMA public TO transit_app;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO transit_app;


CREATE ROLE debezium_replicator WITH LOGIN PASSWORD 'deb_rpl_pass_4321' REPLICATION;
GRANT CONNECT ON DATABASE nyc_transit_oltp TO debezium_replicator;

GRANT SELECT ON vehicle_current_state TO debezium_replicator;
GRANT ALL PRIVILEGES ON vehicle_current_state TO transit_app;

GRANT SELECT ON trip_update_current_state TO debezium_replicator;
GRANT ALL PRIVILEGES ON trip_update_current_state TO transit_app;

CREATE PUBLICATION dbz_publication FOR TABLE vehicle_current_state;
CREATE PUBLICATION dbz_publication FOR TABLE trip_update_current_state;

-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO transit_app;
-- GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO transit_app;"
