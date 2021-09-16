
if [ "$1" == "" ] 
then
    instance=6
else instance=$1
fi

echo "Spinning up $instance instances"

check_server() {
    servers_up=`docker exec -it digicert_seed_node_a_1 dsetool status | grep UN | wc -l`
    if [ $servers_up != "$1" ]
    then
        echo "Waiting for the server to come up"
        sleep 5
        check_server $1
    else
        echo "Node --> $1 came up"
    fi
}

echo "Tearing down any existing setup"
docker-compose -f docker-compose.yaml down

echo 'Starting transactional seed node'
docker-compose -f docker-compose.yaml up -d --scale seed_node_a=1 --scale ds-studio=1 --scale seed_node_b=0 --scale nodea=0 --scale nodeb=0 --remove-orphans

check_server 1

echo 'Starting analytical seed node'
docker-compose -f docker-compose.yaml up -d --scale seed_node_b=1 --scale nodea=0 --scale nodeb=0 

check_server 2

echo 'Starting transactional node'
docker-compose -f docker-compose.yaml up -d --scale nodea=1 --scale nodeb=0

check_server 3

echo 'Starting transactional node'
docker-compose -f docker-compose.yaml up -d --scale nodea=2 --scale nodeb=0

check_server 4

echo 'Starting analytical node'
docker-compose -f docker-compose.yaml up -d --scale nodeb=1 --scale nodea=2

check_server 5

echo 'Starting analytical node'
docker-compose -f docker-compose.yaml up -d --scale nodeb=2 --scale nodea=2 

check_server 6

echo 'All nodes started'

# docker exec -it digicert_seed_node_a_1 dsetool status

echo "Setting up all the spark related keyspaces"
docker exec -it digicert_seed_node_a_1 cqlsh -u cassandra -p cassandra -e "ALTER KEYSPACE cfs WITH replication = {'class': 'NetworkTopologyStrategy', 'analytics':3};
ALTER KEYSPACE cfs_archive WITH replication = {'class': 'NetworkTopologyStrategy', 'analytics':3};
ALTER KEYSPACE dse_leases WITH replication = {'class': 'NetworkTopologyStrategy', 'analytics':3};
ALTER KEYSPACE dsefs WITH replication = {'class': 'NetworkTopologyStrategy', 'analytics':3};
ALTER KEYSPACE \"HiveMetaStore\" WITH replication = {'class': 'NetworkTopologyStrategy', 'analytics':3};
ALTER KEYSPACE spark_system WITH replication = {'class': 'NetworkTopologyStrategy', 'analytics':3};"

echo "Do all the node repair"
for i in `docker container ls | awk '{print $1}' | grep -v "CONTAINER"`
do docker exec -it $i nodetool repair -full
done

echo "Cluster is up and ready to be used"