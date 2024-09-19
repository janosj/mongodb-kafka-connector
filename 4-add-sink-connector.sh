# Adds a MongoDB Sink Connector using the Kafka Connect REST API
# (the API for managing connectors).

# To access this API from your local machine requires port 8083
# (the default Kafka Connect port) to be opened.
# The Quick Start Sandbox isn't normally configured to do this
# (it has you run the command from inside the Docker container),
# but the startKafkaSandbox script provided here adds a line to the
# docker-compose yaml file to open the port.

# Note the url changes from http://connect to http://localhost

# These settings differ from the Quick Start Sandbox,
# which uses the change data capture handler.
# This demo does not insert data into Mongo directly,
# it uses a Kafka producer instead.

echo 
echo "Creating Sink connector via Kafka Connect REST API . . . "
echo 

curl -X POST \
     -H "Content-Type: application/json" \
     --data '
     {"name": "mongo-sink",
      "config": {
         "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
         "connection.uri":"mongodb://mongo1:27017/?replicaSet=rs0",
         "database":"quickstart",
         "collection":"topicData",
         "topics":"quickstart.sampleData",
         "change.data.capture.handler": "com.mongodb.kafka.connect.sink.cdc.mongodb.ChangeStreamHandler"
         }
     }
     ' \
     http://localhost:8083/connectors -w "\n"

# Note: it may 'Fail to connect' if the Connect REST API hasn't started.
# This could take a few minutes. 
# Wait, and then try again. 

echo 
echo "Done."
echo "Verifying . . ."
curl -X GET http://localhost:8083/connectors

echo
echo
echo "To delete the connector:"
echo "curl -X DELETE http://localhost:8083/connectors/mongo-sink"
echo


