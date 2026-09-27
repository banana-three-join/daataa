CREATE SCHEMA warehouse;

CREATE TABLE warehouse.healthcheck (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    message text NOT NULL,
    created_at timestamptz NOT NULL DEFAULT now()
);

INSERT INTO warehouse.healthcheck (message)
VALUES ('Warehouse is healthy');