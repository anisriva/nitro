FROM datastax/dse-server:5.1.24

USER root

RUN apt-get update
RUN apt-get -y install python3
RUN apt-get -y install python3-pip
RUN python3 -m pip install py4j

USER dse