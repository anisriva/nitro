check_server() {
    servers_up=`docker exec trans-seed dsetool status | grep UN | wc -l`
    if [ $servers_up != "$1" ]
    then
        echo "Waiting for the server to come up"
        sleep 5
        check_server $1
    else
        echo "Node --> $1 came up"
    fi
}

cleanup(){
    if [ "$1" == "fresh" ] && [ -d "mnt" ]
    then
        echo "Cleaning up the directory"
        rm -rf mnt/
    else
        echo 'Normal Start'
    fi
}

compose_path='C:\GitHub\Work\Nitro\final\spark\dse-analytics\docker-compose.yaml'

echo "Tearing down any existing setup"
docker-compose -f $compose_path down

cleanup $1

echo 'Starting transactional seed node'
docker-compose -f $compose_path up -d \
--scale trans-seed=1 \
--scale analytics-seed=0 \
--scale ds-studio=1 \
--scale trans-node-1=0 \
--scale trans-node-2=0 \
--scale analytics-node-1=0 \
--scale analytics-node-2=0 \
--remove-orphans

check_server 1

echo 'Starting analytical seed node'
docker-compose -f $compose_path up -d \
--scale analytics-seed=1 \
--scale trans-node-1=0 \
--scale trans-node-2=0 \
--scale analytics-node-1=0 \
--scale analytics-node-2=0 

check_server 2

# echo 'Starting transactional node'
# docker-compose -f $compose_path up -d \
# --scale trans-node-1=1 \
# --scale trans-node-2=0 \
# --scale analytics-node-1=0 \
# --scale analytics-node-2=0 

# check_server 3

# echo 'Starting transactional node'
# docker-compose -f $compose_path up -d \
# --scale trans-node-2=1 \
# --scale analytics-node-1=0 \
# --scale analytics-node-2=0 

# check_server 4

# echo 'Starting analytical node'
# docker-compose -f $compose_path up -d \
# --scale analytics-node-1=1 \
# --scale analytics-node-2=0 

# check_server 5

# echo 'Starting analytical node'
# docker-compose -f $compose_path up -d \
# --scale analytics-node-2=1

# check_server 6

echo 'All nodes started'

while ! docker exec analytics-seed grep -q "DSE startup complete" //var//log//cassandra//system.log
do
  sleep 10
  echo 'Waiting for Analytics cluster to stabalize'
done;

echo 'All nodes started, setting up all the spark related keyspaces' 

sleep 60 

echo "Setting up all the spark related keyspaces"
docker exec trans-seed cqlsh -u cassandra -p cassandra -e "ALTER KEYSPACE cfs WITH replication = {'class': 'NetworkTopologyStrategy', 'analytics':1};
ALTER KEYSPACE cfs_archive WITH replication = {'class': 'NetworkTopologyStrategy', 'analytics':1};
ALTER KEYSPACE dse_leases WITH replication = {'class': 'NetworkTopologyStrategy', 'analytics':1};
ALTER KEYSPACE dsefs WITH replication = {'class': 'NetworkTopologyStrategy', 'analytics':1};
ALTER KEYSPACE \"HiveMetaStore\" WITH replication = {'class': 'NetworkTopologyStrategy', 'analytics':1};
ALTER KEYSPACE spark_system WITH replication = {'class': 'NetworkTopologyStrategy', 'analytics':1};"

while !  docker exec analytics-seed grep -q "SPARK-WORKER service is running" //var//log//spark//worker//worker.log
do
  sleep 10
  echo 'Waiting for Spark Worker to start'
done;

while ! docker exec analytics-seed grep -q "SPARK-MASTER service is running" //var//log//spark//master//master.log
do
  sleep 10
  echo 'Waiting for Spark Master to start'
done;

echo "Do all the node repair"
docker exec trans-seed nodetool repair -full
docker exec analytics-seed nodetool repair -full

if [ -d "mnt\cassandra\analytics-seed\cassandra\data\PortfolioDemo" ]
then
    echo "Keyspace already created skipping creation"
else
    echo "Creating portfolio schema in the transactional datacenter"
    docker exec trans-seed //opt//dse//demos//portfolio_manager//bin//pricer -o INSERT_PRICES
    docker exec trans-seed //opt//dse//demos//portfolio_manager//bin//pricer -o UPDATE_PORTFOLIOS
    docker exec trans-seed //opt//dse//demos//portfolio_manager//bin//pricer -o INSERT_HISTORICAL_PRICES -n 100
    
    echo "Altering portfolio keyspace"
    
    docker exec trans-seed \
     cqlsh -u cassandra \
     -p cassandra \
     -e "ALTER KEYSPACE \"PortfolioDemo\" WITH replication = {'class': 'NetworkTopologyStrategy', 'trans':1, 'analytics':1};"
    
    echo "Redistribute data, do all the node repair"
    for i in `docker container ls | awk '{print $1}' | grep -v "CONTAINER"`
    do docker exec $i nodetool repair -full
    done
fi

echo "Starting thrift server"
docker exec analytics-seed dse spark-sql-thriftserver start --hiveconf hive.server2.thrift.client.user=dse hive.server2.thrift.client.password=dse

echo "Starting jupyter notebook"
docker exec analytics-seed sh //opt//dse//resources//spark//bin//start_jupyter.sh

echo "Use below link to login to jupyter notebook:
        http://localhost:8888
"

echo "Connection String to connect to spark sql using sql clients : 
    url : jdbc:hive2://localhost:10000/PortfolioDemo
    uname : dse
    password : dse
"