# Adds a MongoDB Source Connector using the Kafka Connect REST API
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
echo "Creating Source connector via Kafka Connect REST API . . . "
echo 

curl -X POST \
     -H "Content-Type: application/json" \
     --data '
     {"name": "mongo-source",
      "config": {
         "connector.class":"com.mongodb.kafka.connect.MongoSourceConnector",
         "connection.uri":"mongodb://mongo1:27017/?replicaSet=rs0",
         "database":"quickstart",
         "collection":"sampleData",
         "pipeline":"[{\"$match\": {\"operationType\": \"insert\"}}, {$addFields : {\"fullDocument.travel\":\"MongoDB Kafka Connector\"}}]"
         }
     }
     ' \
     http://localhost:8083/connectors -w "\n"

echo 
echo "Done."
echo "Verifying . . ."
curl -X GET http://localhost:8083/connectors

echo 
echo
echo "Note: an 'Empty reply from server' probably means that "
echo "Kafka Connect hasn't has a chance to start up yet."
echo "Wait a few seconds and then rerun the script."

echo
echo "To delete the connector:"
echo "curl -X DELETE http://localhost:8083/connectors/mongo-source"
echo


