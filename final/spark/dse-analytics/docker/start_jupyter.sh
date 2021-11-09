#!/bin/bash
mkdir -p /var/lib/spark/jupyter
cd /var/lib/spark/jupyter
nohup jupyter notebook --ip=analytics-seed --port=8888 --NotebookApp.token='' --NotebookApp.password='' &

echo password | sudo -S /etc/init.d/ssh start