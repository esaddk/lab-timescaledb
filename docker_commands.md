## pull timescale image
docker pull timescale/timescaledb:latest-pg14

## run container
docker run -d --name timescaledb -p 5432:5432 -e POSTGRES_PASSWORD=pastikuat timescale/timescaledb:latest-pg14

## check docker already running
docker ps

## connect to your timescale
psql -h localhost -p 5432 -U postgres

