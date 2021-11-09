FROM datastax/dse-server:5.1.24

USER root

ENV PYTHONPATH=${PYTHONPATH}:/opt/dse/resources/spark/python/

COPY start_jupyter.sh /opt/dse/resources/spark/bin/start_jupyter.sh

RUN   usermod -a -G sudo dse && \
      apt-get update -y && \
      apt-get install curl ssh -y && \
      curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py && \
      python get-pip.py && \
      python2 -m pip install py4j jupyter cassandra-driver && \
      echo 'dse:password' | chpasswd 

USER dse