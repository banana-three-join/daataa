# Scope

Daataa is a batch data pipeline built end to end on local infrastructure:

- A simulated ERP database as the data source
- A Python pipeline that extracts from the ERP and loads into a warehouse
- A warehouse database modelled for analysis
- An analysis layer and a UI on top of the warehouse
- Everything reproducible from a clean clone with Docker Compose and `make`

## Learning goals

- **Docker:** networks, volumes, secrets, health checks, service dependencies
- **Databases:** role-based access, persistence, backups
- **Pipelines:** idempotent, incremental loads
- **Python:** data extraction, transformation and analysis
- **Golang**
- **Tooling:** Makefile, shell scripting, CI
- **Quality:** testing, logging
- **Documentation:** useful to both people and AI agents
- **Running environments:** locally and in Docker

## Out of scope

- Connecting to a real ERP; source data is generated
- Real-time or streaming ingestion; the pipeline runs in batches
- Production hosting, high availability and replication
- Secret encryption at rest (e.g. Vault or Docker Swarm secrets)