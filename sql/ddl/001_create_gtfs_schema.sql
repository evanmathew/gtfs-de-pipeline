
CREATE DATABASE nyc_transit_oltp;
 
CREATE ROLE transit_app WITH LOGIN PASSWORD 'transit_pass_4321';
GRANT CONNECT ON DATABASE nyc_transit_oltp TO transit_app;
GRANT USAGE, CREATE ON SCHEMA public TO transit_app;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO transit_app;


CREATE ROLE debezium_replicator WITH LOGIN PASSWORD 'deb_rpl_pass_4321' REPLICATION;
GRANT CONNECT ON DATABASE nyc_transit_oltp TO debezium_replicator;

