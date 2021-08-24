FROM datastax/dse-server:5.1.24

# RUN apt-get update && \
#     apt-get install -y curl sudo  && \
#     sudo apt install -y openjdk-8-jdk

ENV DEBEZIUM_VERSION=1.6.1.Final \
    MAVEN_CENTRAL="https://repo1.maven.org/maven2" \
    CASSANDRA_YAML=/config \
    DOWNLOAD_HOME=/opt/dse/resources/debezium/wrk \
    # DOWNLOAD_HOME=/opt/dse/resources/debezium \
    DEBEZIUM_HOME=/opt/dse/resources/debezium

COPY dc_config/cassandra.yaml $CASSANDRA_YAML
COPY dc_config/dse.yaml $CASSANDRA_YAML

RUN mkdir $DEBEZIUM_HOME && \
    mkdir $DOWNLOAD_HOME 
RUN curl -fSL -o $DOWNLOAD_HOME/debezium-connector-cassandra.jar \
                 $MAVEN_CENTRAL/io/debezium/debezium-connector-cassandra/$DEBEZIUM_VERSION/debezium-connector-cassandra-$DEBEZIUM_VERSION-jar-with-dependencies.jar

COPY log4j.properties config.properties inventory.cql $DOWNLOAD_HOME/
COPY startup-script.sh $DOWNLOAD_HOME/startup-script.sh

# RUN chmod +x $DEBEZIUM_HOME/startup-script.sh &&\
#     chown -R dse:dse $CASSANDRA_YAML/cassandra.yaml $DEBEZIUM_HOME

RUN cp $DOWNLOAD_HOME/config.properties $DEBEZIUM_HOME/config.properties && \
    cp $DOWNLOAD_HOME/inventory.cql $DEBEZIUM_HOME/inventory.cql && \
    cp $DOWNLOAD_HOME/log4j.properties $DEBEZIUM_HOME/log4j.properties && \
    cp $DOWNLOAD_HOME/startup-script.sh $DEBEZIUM_HOME/startup-script.sh && \
    chmod +x $DEBEZIUM_HOME/config.properties && \
    chmod +x $DEBEZIUM_HOME/inventory.cql && \
    chmod +x $DEBEZIUM_HOME/log4j.properties && \
    chmod +x $DEBEZIUM_HOME/startup-script.sh && \
    # chmod +x $CASSANDRA_YAML/cassandra.yaml && \
    chown -R dse:dse $DEBEZIUM_HOME/config.properties $DEBEZIUM_HOME && \
    chown -R dse:dse $DEBEZIUM_HOME/inventory.cql $DEBEZIUM_HOME && \
    chown -R dse:dse $DEBEZIUM_HOME/log4j.properties $DEBEZIUM_HOME && \
    chown -R dse:dse $DEBEZIUM_HOME/startup-script.sh $DEBEZIUM_HOME 
    # chown -R dse:dse $CASSANDRA_YAML/cassandra.yaml $DEBEZIUM_HOME

USER dse

RUN mkdir -p $DEBEZIUM_HOME/relocation/archive $DEBEZIUM_HOME/relocation/error
CMD $DEBEZIUM_HOME/startup-script.sh
