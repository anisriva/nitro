#!/bin/sh

# sh /opt/cassandra/bin/cassandra -f &


mkdir $DEBEZIUM_HOME

curl -fSL -o $DEBEZIUM_HOME/debezium-connector-cassandra.jar \
                 $MAVEN_CENTRAL/io/debezium/debezium-connector-cassandra/$DEBEZIUM_VERSION/debezium-connector-cassandra-$DEBEZIUM_VERSION-jar-with-dependencies.jar

cp /home/config.properties $DEBEZIUM_HOME/config.properties
cp /home/inventory.cql $DEBEZIUM_HOME/inventory.cql
cp /home/log4j.properties $DEBEZIUM_HOME/log4j.properties
cp /home/startup-script.sh $DEBEZIUM_HOME/startup-script.sh

chmod +x $DEBEZIUM_HOME/config.properties
chmod +x $DEBEZIUM_HOME/inventory.cql
chmod +x $DEBEZIUM_HOME/log4j.properties
chmod +x $DEBEZIUM_HOME/startup-script.sh
chmod +x $CASSANDRA_YAML/cassandra.yaml

chown -R dse:dse $DEBEZIUM_HOME/config.properties $DEBEZIUM_HOME
chown -R dse:dse $DEBEZIUM_HOME/inventory.cql $DEBEZIUM_HOME
chown -R dse:dse $DEBEZIUM_HOME/log4j.properties $DEBEZIUM_HOME
chown -R dse:dse $DEBEZIUM_HOME/startup-script.sh $DEBEZIUM_HOME
chown -R dse:dse $CASSANDRA_YAML/cassandra.yaml $DEBEZIUM_HOME

cqlsh -f $DEBEZIUM_HOME/inventory.cql

cd $DEBEZIUM_HOME

while ! grep -q "Created default superuser role 'cassandra" /var/log/cassandra/system.log
do
  sleep 1
done;

java -Dlog4j.debug \
-Dlog4j.configuration=file:$DEBEZIUM_HOME/log4j.properties \
-jar $DEBEZIUM_HOME/debezium-connector-cassandra.jar \
$DEBEZIUM_HOME/config.properties >  $DEBEZIUM_HOME/debezium.stdout.log 2> $DEBEZIUM_HOME/debezium.stderr.log