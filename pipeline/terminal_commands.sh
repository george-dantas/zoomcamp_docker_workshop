# !/bin/bash

# This script is used to run a PostgreSQL container for the NY Taxi dataset.
docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v ny_taxi_postgres_data:/var/lib/postgresql \
  -p 5432:5432 \
  postgres:18

# After running the above command, you can connect to the PostgreSQL database using pgcli with the following command:
uv run pgcli -h localhost -p 5432 -u root -d ny_taxi


# After the PostgreSQL container is running, you can ingest the NY Taxi dataset into the database using the following command: 
uv run python ingest_data.py \
  --pg-user=root \
  --pg-pass=root \
  --pg-host=localhost \
  --pg-port=5432 \
  --pg-db=ny_taxi \
  --target-table=yellow_taxi_trips

# After the data ingestion is complete, you can run the following command to verify that the data has been successfully ingested into the database: 
uv run python ingest_zones_data.py \
  --pg-user=root \
  --pg-pass=root \
  --pg-host=localhost \
  --pg-port=5432 \
  --pg-db=ny_taxi \
  --target-table=zones