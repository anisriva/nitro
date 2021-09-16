FROM datastax/dse-server:5.1.24

USER root

ENV PYTHONPATH=${PYTHONPATH}:/opt/dse/resources/spark/python/

RUN   apt-get update && \
      apt-get install curl && \
      curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py && \
      python get-pip.py && \
      python2 -m pip install py4j, jupyter && \
      usermod -a -G sudo dse && \
      nohup /opt/dse/.local/bin/jupyter notebook --ip=dse-analytics-0 --port=8888 &

USER dse