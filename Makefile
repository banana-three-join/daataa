## Variable definition

SECRETS_DIR := secrets
ERP_ADMIN_PASSWORD_PATH       := $(SECRETS_DIR)/erp_admin_password.txt
ERP_USER_PASSWORD_PATH        := $(SECRETS_DIR)/erp_user_password.txt
WAREHOUSE_ADMIN_PASSWORD_PATH := $(SECRETS_DIR)/warehouse_admin_password.txt
WAREHOUSE_ETL_USER_PASSWORD_PATH  := $(SECRETS_DIR)/warehouse_etl_user_password.txt
WAREHOUSE_USER_PASSWORD_PATH  := $(SECRETS_DIR)/warehouse_user_password.txt

## ERP targets

.PHONY: erp-setup-secrets

erp-setup-secrets: $(ERP_ADMIN_PASSWORD_PATH) $(ERP_USER_PASSWORD_PATH)

## Warehouse targets

.PHONY: warehouse-setup-secrets

warehouse-setup-secrets: $(WAREHOUSE_ADMIN_PASSWORD_PATH) $(WAREHOUSE_ETL_USER_PASSWORD_PATH) $(WAREHOUSE_USER_PASSWORD_PATH)

## Helpers

$(SECRETS_DIR)/%_password.txt:
	@command -v openssl >/dev/null 2>&1 || { echo "openssl not found: install it or create $@ manually"; exit 1; }
	@mkdir -p $(@D)
	@openssl rand -hex 32 > $@ && chmod 644 $@
	@echo "Generated $@"