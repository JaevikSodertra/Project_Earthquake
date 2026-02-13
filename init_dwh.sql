CREATE SCHEMA IF NOT EXISTS ods;

CREATE TABLE IF NOT EXISTS ods.fct_earthquake (
    time        TIMESTAMP,
    latitude    DOUBLE PRECISION,
    longitude   DOUBLE PRECISION,
    depth       DOUBLE PRECISION,
    mag         DOUBLE PRECISION,
    mag_type    VARCHAR(16),
    nst         INTEGER,
    gap         DOUBLE PRECISION,
    dmin        DOUBLE PRECISION,
    rms         DOUBLE PRECISION,
    net         VARCHAR(16),
    id          VARCHAR(64) PRIMARY KEY,
    updated     TIMESTAMP,
    place       VARCHAR(256),
    type        VARCHAR(32),
    horizontal_error DOUBLE PRECISION,
    depth_error      DOUBLE PRECISION,
    mag_error        DOUBLE PRECISION,
    mag_nst          INTEGER,
    status           VARCHAR(16),
    location_source  VARCHAR(16),
    mag_source       VARCHAR(16)
);
