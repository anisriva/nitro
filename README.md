# **Project Nitro PoC**

## **Introduction**

The POC on this project was focused on getting a technology which can enable us to centralize the data from our cassandra database into our MH lake which is a Mariadb database.

Below were some technologies and third-party vendors who I reached out to:

- Confluent Kafka source connector
- DataStax Kafka source connector
- Cdata source for Cassandra
- Impetus professional services
- InstaClustr Inc.
- Debezium Kafka producer
- Spark (DSE Analytics)

Because of limitation with other options Debeizium and DSE Analytics turned out to be the best choices.

![flow](resource\flow.png)

## **Part 1 : Debezium**

Debezium Cassandra connector is a single JVM process that is intended to reside on each Cassandra node and publishes events to Kafka via a Kafka producer.

The connector reads the commit logs from the cdc\_raw directory and published the messages to the kafka broker.

The write path of Cassandra starts with the immediate logging of a change into its commit log. The commit log resides locally on each node, recording every write made to that node.

Since Cassandra 3.0, a [change data capture (CDC) feature](http://cassandra.apache.org/doc/3.11.3/operating/cdc.html) is introduced. The CDC feature can be enabled on the table level by setting the table property cdc=true, after which any commit log containing data for a CDC-enabled table will be moved to the CDC directory specified in cassandra.yaml on discard.

The Cassandra connector resides on each Cassandra node and monitors the cdc\_raw directory for change (configurable via cassandra.yml).

- It processes all local commit log segments as they are detected
- Produces a change event for every row-level insert, update, and delete operations in the commit log
- Publishes all change events for each table in a separate Kafka topic
- Finally deletes the commit log from the cdc\_raw directory.

This last step is important because once CDC is enabled, Cassandra itself cannot purge the commit logs. If the cdc\_free\_space\_in\_mb fills up, writes to CDC-enabled tables will be rejected.

The connector is tolerant of failures. As the connector reads commit logs and produces events, it records each commit log segment’s filename and position along with each event. If the connector stops for any reason (including communication failures, network problems, or crashes), upon restart it simply continues reading the commit log where it last left off. This includes snapshots: if the snapshot was not completed when the connector is stopped, upon restart it will begin a new snapshot.

### **Technical Requirements**

- Debezium connector on Cassandra nodes
- Kafka broker
- Custom kafka consumer for Cassandra
- Apache Airflow

### **Configurations on Cassandra side:**

1. **Node level**
   1. **cdc\_enabled:** Enables or disables CDC operations node-wide
      ```cdc_enabled: true```
   1. **cdc\_raw\_directory:** Determines the destination for commit log segments to be moved after all corresponding memtables are flushed
      ```cdc_raw_directory: $CASSANDRA_HOME/data/cdc_raw```
   1. **cdc\_total\_space\_in\_mb:** The maximum capacity allocated to store commit log segments, and defaults to the minimum of 4096 MB and 1/8 of volume space where the cdc\_raw\_directory resides.
      ```cdc_total_space_in_mb: 4096```
   1. **cdc\_free\_space\_check\_interval\_ms:** Frequency with which we re-calculate the space taken up by cdc\_raw\_directory to prevent burning CPU cycles unnecessarily when at capacity
      ```cdc_free_space_check_interval_ms: 250```
   1. **commitlog\_total\_space\_in\_mb:** Disk usage threshold for commit logs before triggering the database to flush memtables to disk. If the total space used by all commit logs exceeds this threshold, the database flushes memtables to disk for the oldest commitlog segments to reclaim disk space by removing those log segments from the log. If the commitlog\_total\_space\_in\_mb is small, the result is more flush activity on less-active tables.
      ```commitlog_total_space_in_mb:100```
1. **Table Level:** While creating a new table cdc=true should be enabled and all the existing tables should be altered to have cdc=true property.

   1. **Create table**

   ```CREATE TABLE foo (a int, b text, PRIMARY KEY(a)) WITH cdc=true;```

   2. **Alter table**

   ```ALTER TABLE foo WITH cdc=true;```

### **Flow pipeline:**

First Half (Cassandra to Kafka)

![debezium](resource\debezium-connector.png)

Second Half (Kafka to Mariadb)

**Yet to be decided**

### **Problems, Limitations & Challenges:**

- **CDC**
  - Commit logs on an individual Cassandra node do not reflect all writes to the cluster, they only reflect writes stored on that node. Therefore, it is necessary to monitor changes on all nodes in a Cassandra cluster.
  - Due to replication factor, it is necessary for downstream consumers of these events to handle deduplication.
  - Commit logs only arrive in cdc\_raw directory when it is full, in which case it would be flushed/discarded. This implies there is a delay between when the event is logged and when the event is captured.
  - Schema changes of tables are not recorded in commit logs, only data changes are recorded.
- **Debezium**
  - If the connector goes down for any reason, then it can lead to accumulation of commit log files in the cdc\_raw directory and bloat up disk storage because cassandra itself cannot purge the commit logs. If the cdc\_free\_space\_in\_mb fills up, writes to CDC-enabled tables will be rejected.
  - Unable to identify snitching properties:  Connector couldn’t identify other snitching properties which is a known bug ( <https://issues.redhat.com/browse/DBZ-1987> )

**Resolution:** Create a separate cassandra.yaml with SimpleSnitch property as gossip method and provide its path to the config.properties file of the debezium connector.

- Connector couldn’t identify replication strategy: EverywhereStrategy

**Resolution:** Convert all the keyspaces which are configured as EverywhereStrategy to NetworkTopology Strategy.

**Note : Both of the above problems were reported internally  here : [**https://digicertinc.atlassian.net/browse/DATA-3399](https://digicertinc.atlassian.net/browse/DATA-3399)**

- **Downstream Sinks**
  - Schema changes of tables are not recorded in commit logs, only data changes are recorded. Therefore changes in schema are detected on a best-effort basis. To avoid data loss, it is recommended to pause writes to the table during schema change.
  - There is no direct 1-to-1 mapping between Cassandra's datatypes and MySQL/MariaDB datatypes.
  - Cassandra's size limitations are often more relaxed than MySQL/MariaDB's. For example, Cassandra's limit on rowkey length is about 2G, while MySQL limits unique key length to about 1.5Kb.
  - Unsupported Datatypes such as UDTs, Complex Data types.

### **Inhouse Setup**

1. Git clone the [debezium poc](https://github.com/anisriva/debezium-dse) repo
   ```git clone https://github.com/anisriva/debezium-dse.git```
1. Start the docker-compose
   ```docker-compose -f docker-compose.yaml up -d```
1. Run startup script to:
   1. Move the connectors binaries and config to $DEBEZIUM\_HOME
   1. Change the EverywhereStrategy to NetworkTopology
   1. Create a dummy schema in the Cassandra db
   1. Start debezium process
   1. Insert huge number of records in customers table
      ```docker container exec -it cassandra sh //home//startup-script.sh```
1. Check out the debezium logs:
   ```docker container exec -it cassandra-dse cat //opt//dse//resources//debezium//debezium.stderr.log```
1. Check kafka manager to see the topics being created in the cluster or not.

   <https://localhost:9000>

### **Summary:**

The above setup is just the first half of the pipeline the next half of the pipeline requires new phase of development and design. A better approach to this problem will be to have a system which can:

- Support the varied verities of datatypes that is required to be incorporated.
- Should be able to remove the duplicates which will be generated due to the replication factor.

Because of above limitations and problems, I decided to move towards the DSE Analytics route. In next section we will discuss about DSE Analytics workload and Spark.

## **Part 2 : DSE Analytics (Spark)**

Apache Spark is a high performing engine for large-scale analytics and data processing. While Apache Spark provides advanced analytics capabilities, it requires a fast, distributed backend data store. Apache Cassandra is the most modern, reliable, and scalable choice for that data store. Spark when fully integrated with the key components of Cassandra, provides the resilience and scale required for big data analytics.

Cassandra is a highly scalable NoSql db which provides a very efficient write path with limitations in the way we read data. Cassandra exposes CQL which is a SQL like interface to fetch data but has major limitations with common sql like functionalities like joins, groups, and complex aggregations on top of the data.

DSE Analytics provides an isolated layer on top of the transactional system for analytical workloads and data needs. This requires a creation of a separate datacenter within the same cluster with additional hardware resources.

This setup can be implemented on top of the current datacenter as well but its highly recommended to have a separate isolated workload for running spark jobs as this will be a resource intensive task and we don’t want our applications to be affected by it.

Spark supports a rich set of higher-level tools including:

- Spark SQL
- MLlib
- GraphX
- Spark Streaming

### **Technical Requirements**

- Cassandra
- Spark
  - Spark SQL
  - Scala or PySpark
- Airflow

### **Configurations on Cassandra side**

To setup the analytical workload below operations is required to be performed.

1. Allocate the analytical nodes.
1. Join the nodes as a separate datacenter into the cluster.
1. Configure the keyspaces to ensure they replicate in the analytical DC
1. Perform node repair on the impacted keyspaces.

### **Resource Allocation**

#### **Current Node configuration for existing cluster (Transactional Datacenter)**

|**Data Per Node**|**CPU/Chipset** |**Memory** |**Disk**|**Network**|
| :-: | :-: | :-: | :-: | :-: |
|817GB per node +/- 295GB|28 CPU Cores|128GB |3.2TB |1.6TB solr\_data|
We have a 8 node transactional data center and we are planning to go for either a 3 or a 6 node analytics datacenter.

#### **Probable configuration for a 3 node cluster (Analytics Datacenter)**

|**Data Per Node**|**CPU/Chipset** |**Memory** |**Disk**|**Network**|
| :-: | :-: | :-: | :-: | :-: |
|~ 2.5 TB per node|28 CPU Cores or higher if available|320GB|5 TB|1.6TB solr\_data|

#### **Probable configuration for a 6 node cluster (Analytics Datacenter)**

|**Data Per Node**|**CPU/Chipset** |**Memory** |**Disk**|**Network**|
| :-: | :-: | :-: | :-: | :-: |
|~ 1.5 TB per node|28 CPU Cores or higher if available|256 GB|4 TB|1.6TB solr\_data|

### **Setup Diagram**

![dse-collated](resource\dse-collated.png) ![dse-isolated](resource\dse-isolated.png)

### **Thriftserver for SQL like feature**

The Spark SQL Thriftserver uses JDBC and ODBC interfaces for client connections to the database.

The AlwaysOn SQL service is a high-availability service built on top of the Spark SQL Thriftserver. The Spark SQL Thriftserver is started manually on a single node in an Analytics datacenter, and will not failover to another node. Both AlwaysOn SQL and the Spark SQL Thriftserver provide JDBC and ODBC interfaces to DSE, and share many configuration settings.

The inhouse setup includes the thriftserver setup and no additional work is required. For more information please see this documentation.

<https://docs.datastax.com/en/dse/6.8/dse-dev/datastax_enterprise/spark/sparkSqlThriftServer.html>

**NOTE:** AlwaysOnSQL is only available in DSE 6.x therefore we will use only thrift server in this setup

### **Inhouse Setup**

1. Git clone the [dse-analytics-spark](https://github.com/anisriva/dse-analytics-spark.git) repository from github.
   ```git clone https://github.com/anisriva/dse-analytics-spark.git```
1. Enter the directory
   ```cd dse-analytics-spark```
1. Use the spark script to run the setup
   ```sh start.sh```
1. Run DSE-studio using below link
   [DS-Studio](http://localhost:8080)
1. Run Jupyter notebook by following below steps
   1. Enter inside the docker contianer
      ```docker container exec -it analytics-seed bash```
   1. Go the work directory
      ```cd /var/lib/spark/jupyter```
   1. Start Jupyter notebook
      ```nohup jupyter notebook --ip=analytics-seed --port=8888 --NotebookApp.token='' --NotebookApp.password='' &```
   1. Exit out of docker container
      ```exit```

1. Use below link to access the jupyter notebook
   [Jupyter](http://localhost:8888)
1. Using Spark shell
   1. Spark-sql
      ```docker container exec -it analytics-seed dse spark-sql```
   1. Spark-scala
      ```docker container exec -it analytics-seed dse spark```
   1. Pyspark
      ```docker container exec -it analytics-seed dse pyspark```
1. Setting up spark sql on sql client like dbeaver:
   1. Install Dbeaver thru below link:
      <https://dbeaver.com/download/lite/>
   2. Click on database on the menu bar and click on new database connection.
   3. Select **Apache Hive**
      ![Hive Setup](resource\hive-setup.png)
   4. Click next and setup the JDBC parameters as show in below image
      ![Connection String](resource\hive-uri.png)
   5. Now we are all set to start running HQL queries
      ![HQL](resource\hql.png)

**Note** : 10000 port should be exposed for the docker container and for username and password use “dse”
