FROM datastax/dse-server:5.1.24
USER root
RUN apt-get update
COPY everywhere-strategy-cassandra-4.0-1.0.0.jar /opt/dse/resources/cassandra/lib/everywhere-strategy-cassandra-4.0-1.0.0.jar
RUN chmod 777 /opt/dse/resources/cassandra/lib/everywhere-strategy-cassandra-4.0-1.0.0.jar
# RUN echo "deb https://dl.bintray.com/instaclustr/debian stable main" > \
#     /etc/apt/sources.list.d/instaclustr.sources.list
# RUN apt-get install instaclustr-everywhere-stratgey 
USER dse
ENV DS_LICENSE=accept
