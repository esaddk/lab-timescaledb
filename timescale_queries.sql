## create database
CREATE DATABASE timeseries_test;

## create table
CREATE TABLE sensor_data (
    time TIMESTAMPTZ NOT NULL,
    device_id INT,
    temperature FLOAT,
    humidity FLOAT
);

## create hypertable
SELECT create_hypertable('sensor_data', 'time');

## create index
CREATE INDEX ON sensor_data (device_id);

## create continous aggregation using materialized view
CREATE MATERIALIZED VIEW daily_temperature
WITH (timescaledb.continuous) AS
SELECT time_bucket('1 day', time) AS day,
       device_id,
       AVG(temperature) AS avg_temp
FROM sensor_data
GROUP BY day, device_id;

## create retention policy
SELECT add_retention_policy('sensor_data', INTERVAL '30 days');

## data compression
ALTER TABLE sensor_data SET (timescaledb.compress);
SELECT compress_chunk(i) FROM show_chunks('sensor_data') i;

