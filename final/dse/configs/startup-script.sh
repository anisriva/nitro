#!/bin/sh

# sh /opt/cassandra/bin/cassandra -f &

mkdir $DEBEZIUM_HOME

cp /home/config.properties $DEBEZIUM_HOME/config.properties
cp /home/inventory.sql $DEBEZIUM_HOME/inventory.sql
cp /home/log4j.properties $DEBEZIUM_HOME/log4j.properties
cp /home/startup-script.sh $DEBEZIUM_HOME/startup-script.sh
cp /home/debezium-connector-cassandra.jar $DEBEZIUM_HOME/debezium-connector-cassandra.jar

chmod +x $DEBEZIUM_HOME/config.properties
chmod +x $DEBEZIUM_HOME/inventory.sql
chmod +x $DEBEZIUM_HOME/log4j.properties
chmod +x $DEBEZIUM_HOME/startup-script.sh
# chmod +x $CASSANDRA_YAML/cassandra.yaml
chmod +x $DEBEZIUM_HOME/debezium-connector-cassandra.jar

chown -R dse:dse $DEBEZIUM_HOME/config.properties $DEBEZIUM_HOME
chown -R dse:dse $DEBEZIUM_HOME/inventory.sql $DEBEZIUM_HOME
chown -R dse:dse $DEBEZIUM_HOME/log4j.properties $DEBEZIUM_HOME
chown -R dse:dse $DEBEZIUM_HOME/startup-script.sh $DEBEZIUM_HOME
# chown -R dse:dse $CASSANDRA_YAML/cassandra.yaml $DEBEZIUM_HOME
chown -R dse:dse $DEBEZIUM_HOME/debezium-connector-cassandra.jar $DEBEZIUM_HOME
echo "Files copied to $DEBEZIUM_HOME"
cd $DEBEZIUM_HOME

while ! grep -q "DSE startup complete" /var/log/cassandra/system.log
do
  sleep 10
  echo 'Waiting for DSE to start'
done;

for i in `cqlsh -u cassandra -p cassandra -e "desc full schema" | grep -i everywhere | awk '{print $3}'`;
do
  cqlsh -u cassandra -p cassandra -e  "alter KEYSPACE $i WITH replication = {'class': 'NetworkTopologyStrategy', 'dc1': 1};";
  echo "Converted keyspace:$i from EverywhereStratergy to NetworkTopologyStrategy "
done

cqlsh -f $DEBEZIUM_HOME/inventory.sql
echo 'Testdb Created now starting debezium producer'

java -Dlog4j.debug \
-Dlog4j.configuration=file:$DEBEZIUM_HOME/log4j.properties \
-jar $DEBEZIUM_HOME/debezium-connector-cassandra.jar \
$DEBEZIUM_HOME/config.properties > $DEBEZIUM_HOME/debezium.stdout.log 2> $DEBEZIUM_HOME/debezium.stderr.log &

echo "sleeping for 10 secs before inserting more records"
sleep 10 

echo "Inserting records to customers table"
cqlsh -f /home/inserts.sql
echo "Done inserting the records"