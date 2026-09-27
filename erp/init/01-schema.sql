CREATE SCHEMA erp;

CREATE TABLE erp.healthcheck (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    message text NOT NULL,
    created_at timestamptz NOT NULL DEFAULT now()
);

INSERT INTO erp.healthcheck (message)
VALUES ('ERP is healthy');