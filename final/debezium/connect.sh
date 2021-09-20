   "key.converter":"org.apache.kafka.connect.json.JsonConverter",
   "key.converter.schema.registry.url": "http://schema_registry:8081",
   "value.converter" : "org.apache.kafka.connect.json.JsonConverter",
   "value.converter.schema.registry.url" : "http://schema_registry:8081" 

"key.converter" : "io.confluent.connect.avro.AvroConverter",
"key.converter.schema.registry.url" : "http://localhost:8081",
"key.converter.enhanced.avro.schema.support" : "true",
"value.converter" : "io.confluent.connect.avro.AvroConverter",
"value.converter.schema.registry.url" : "http://localhost:8081",
"value.converter.enhanced.avro.schema.support" : "true"

curl -i -X DELETE -H "Accept:application/json" `hostname`:8083/connectors/cassandra_sink
curl -i -X POST \
-H "Accept:application/json" \
-H "Content-Type:application/json" \
connect:8083/connectors/ \
-d \
'{
    "name": "cassandra_sink",
    "config": {
	"connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
    "tasks.max": "1",
    "topics.regex": "cassandra\\.(.*)\\.(.*)",
    "table.name.format": "${topic}",
    "dialect.name" : "MySqlDatabaseDialect",
    "connection.url": "jdbc:mysql://mysql_target_db:3306/testdb",
    "connection.user":"root",
    "connection.password":"password",
    "connection.attempts":"3",
    "connection.backoff.ms":"10000",
    "auto.create": "true",
    "auto.evolve":"true",    
    "insert.mode": "upsert",
    "delete.enabled" : "true",
    "pk.mode": "record_key",
    "key.converter" : "org.apache.kafka.connect.json.JsonConverter",
    "key.converter.schema.registry.url" : "http://schema_registry:8081",
    "key.converter.enhanced.avro.schema.support" : "true",
    "value.converter" : "org.apache.kafka.connect.json.JsonConverter",
    "value.converter.schema.registry.url" : "http://schema_registry:8081",
    "value.converter.enhanced.avro.schema.support" : "true",
	"transforms": "route,unwrap,inserted,updated",
    "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
    "transforms.unwrap.drop.tombstones" : "false",
    "transforms.unwrap.delete.handling.mode" : "none",
	"transforms.route.type": "org.apache.kafka.connect.transforms.RegexRouter",
	"transforms.route.regex": "([^.]+)\\.([^.]+)\\.([^.]+)",
	"transforms.route.replacement": "$2\\.$3",
    "transforms.inserted.type": "org.apache.kafka.connect.transforms.TimestampConverter$Value",
    "transforms.inserted.target.type": "Timestamp",
    "transforms.inserted.field": "inserted",
    "transforms.inserted.format": "yyyy-MM-dd HH:mm:ss.SSSSSS",
    "transforms.updated.type": "org.apache.kafka.connect.transforms.TimestampConverter$Value",
    "transforms.updated.target.type": "Timestamp",
    "transforms.updated.field": "updated",
    "transforms.updated.format": "yyyy-MM-dd HH:mm:ss.SSSSSS",  
    "decimal.handling.mode":"double"
    }
}'


curl -i -X DELETE -H "Accept:application/json" `hostname`:8083/connectors/cassandra_sink
curl -i -X POST \
-H "Accept:application/json" \
-H "Content-Type:application/json" \
connect:8083/connectors/ \
-d \
'{
    "name": "cassandra_sink",
    "config": {
	"connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
    "tasks.max": "1",
    "topics.regex": "cassandra\\.(.*)\\.(.*)",
    "table.name.format": "${topic}",
    "dialect.name" : "MySqlDatabaseDialect",
    "connection.url": "jdbc:mysql://mysql_target_db:3306/testdb",
    "connection.user":"root",
    "connection.password":"password",
    "connection.attempts":"3",
    "connection.backoff.ms":"10000",
    "auto.create": "true",
    "auto.evolve":"true",    
    "insert.mode": "upsert",
    "delete.enabled" : "true",
    "pk.mode": "record_key",
	"transforms": "route,unwrap,inserted,updated",
    "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
    "transforms.unwrap.drop.tombstones" : "false",
    "transforms.unwrap.delete.handling.mode" : "none",
	"transforms.route.type": "org.apache.kafka.connect.transforms.RegexRouter",
	"transforms.route.regex": "([^.]+)\\.([^.]+)\\.([^.]+)",
	"transforms.route.replacement": "$2\\.$3",
    "transforms.inserted.type": "org.apache.kafka.connect.transforms.TimestampConverter$Value",
    "transforms.inserted.target.type": "Timestamp",
    "transforms.inserted.field": "inserted",
    "transforms.inserted.format": "yyyy-MM-dd HH:mm:ss.SSSSSS",
    "transforms.updated.type": "org.apache.kafka.connect.transforms.TimestampConverter$Value",
    "transforms.updated.target.type": "Timestamp",
    "transforms.updated.field": "updated",
    "transforms.updated.format": "yyyy-MM-dd HH:mm:ss.SSSSSS",  
    "decimal.handling.mode":"double"
    }
}'