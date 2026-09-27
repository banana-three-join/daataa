#!/bin/bash
set -euo pipefail

ETL_PASSWORD="$(cat /run/secrets/warehouse-etl-user-password)"
READER_PASSWORD="$(cat /run/secrets/warehouse-user-password)"

psql -v ON_ERROR_STOP=1 \
     --username "$POSTGRES_USER" \
     --dbname "$POSTGRES_DB" \
     -v db="$POSTGRES_DB" \
     -v etl_user="$WAREHOUSE_ETL_USER" \
     -v etl_password="$ETL_PASSWORD" \
     -v reader="$WAREHOUSE_USER" \
     -v reader_password="$READER_PASSWORD" <<'EOSQL'
REVOKE ALL ON DATABASE :"db" FROM PUBLIC;

CREATE ROLE :"etl_user" WITH LOGIN PASSWORD :'etl_password';
GRANT CONNECT ON DATABASE :"db" TO :"etl_user";
GRANT USAGE ON SCHEMA warehouse TO :"etl_user";
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA warehouse TO :"etl_user";
GRANT USAGE ON ALL SEQUENCES IN SCHEMA warehouse TO :"etl_user";
ALTER DEFAULT PRIVILEGES IN SCHEMA warehouse
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO :"etl_user";
ALTER DEFAULT PRIVILEGES IN SCHEMA warehouse
    GRANT USAGE ON SEQUENCES TO :"etl_user";

CREATE ROLE :"reader" WITH LOGIN PASSWORD :'reader_password';
GRANT CONNECT ON DATABASE :"db" TO :"reader";
GRANT USAGE ON SCHEMA warehouse TO :"reader";
GRANT SELECT ON ALL TABLES IN SCHEMA warehouse TO :"reader";
ALTER DEFAULT PRIVILEGES IN SCHEMA warehouse
    GRANT SELECT ON TABLES TO :"reader";
EOSQL