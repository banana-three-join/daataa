#!/bin/bash
set -euo pipefail

ERP_USER_PASSWORD="$(cat /run/secrets/erp-user-password)"

psql -v ON_ERROR_STOP=1 \
  --username "$POSTGRES_USER" \
  --dbname "$POSTGRES_DB" \
  -v db="$POSTGRES_DB" \
  -v erp_user="$ERP_USER" \
  -v erp_password="$ERP_USER_PASSWORD" <<'EOSQL'
REVOKE ALL ON DATABASE :"db" FROM PUBLIC;

CREATE ROLE :"erp_user" WITH LOGIN PASSWORD :'erp_password';
GRANT CONNECT ON DATABASE :"db" TO :"erp_user";
GRANT USAGE ON SCHEMA erp TO :"erp_user";
GRANT SELECT ON ALL TABLES IN SCHEMA erp TO :"erp_user";
ALTER DEFAULT PRIVILEGES IN SCHEMA erp
    GRANT SELECT ON TABLES TO :"erp_user";
EOSQL