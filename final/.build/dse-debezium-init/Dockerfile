FROM datastax/dse-server:5.1.24

# RUN apt-get update && \
#     apt-get install -y curl sudo  && \
#     sudo apt install -y openjdk-8-jdk

ENV DEBEZIUM_VERSION=1.6.1.Final \
    MAVEN_CENTRAL="https://repo1.maven.org/maven2" \
    CASSANDRA_YAML=/opt/dse/resources/cassandra/conf \
    DEBEZIUM_HOME=/opt/dse/resources/debezium

COPY cassandra.yaml $CASSANDRA_YAML

RUN mkdir $DEBEZIUM_HOME
RUN curl -fSL -o $DEBEZIUM_HOME/debezium-connector-cassandra.jar \
                 $MAVEN_CENTRAL/io/debezium/debezium-connector-cassandra/$DEBEZIUM_VERSION/debezium-connector-cassandra-$DEBEZIUM_VERSION-jar-with-dependencies.jar

COPY log4j.properties config.properties inventory.cql $DEBEZIUM_HOME/
COPY startup-script.sh $DEBEZIUM_HOME/startup-script.sh

RUN chmod +x $DEBEZIUM_HOME/startup-script.sh &&\
    chown -R dse:dse $CASSANDRA_YAML/cassandra.yaml $DEBEZIUM_HOME

USER dse

RUN mkdir -p $DEBEZIUM_HOME/relocation/archive $DEBEZIUM_HOME/relocation/error
CMD $DEBEZIUM_HOME/startup-script.sh
