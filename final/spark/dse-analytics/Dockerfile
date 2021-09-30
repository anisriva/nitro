FROM datastax/dse-server:5.1.24

USER root

COPY .build/build.sh /opt/dse/resources/build.sh

RUN echo 'dse:dse' | chpasswd
ENV PYTHONPATH=${PYTHONPATH}:/opt/dse/resources/spark/python/

# RUN usermod -a -G sudo dse && \
#     apt-get update && \
#     apt-get install curl git gnupg2 -y && \
#     curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py && \
#     python get-pip.py && \
#     pip install py4j && \
#     pip install jupyter && \
#     rm get-pip.py && \
#     cd /opt/dse/resources/spark/python/ && \
#     git clone https://github.com/anguenot/pyspark-cassandra.git && \
#     cd pyspark-cassandra
# RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list && \
#     echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list && \
#     curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add && \
#     apt-get update && \
#     apt-get install sbt 
#     cd /opt/dse/resources/spark/python/pyspark-cassandra && \
#     sbt compile && \
#     apt-get clean

RUN sh /opt/dse/resources/build.sh

USER dse