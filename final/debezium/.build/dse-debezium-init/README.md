# debezium-dse

Debezium connector for DSE

### Initialize the docker compose

`docker-compose -f docker-compose.yaml up -d`

### Start the debezium connector

`docker container exec -it cassandra-dse sh //home//startup-script.sh`

### Check the debezium logs

`docker container exec -it cassandra-dse cat //opt//dse//resources//debezium//debezium.stderr.log`
