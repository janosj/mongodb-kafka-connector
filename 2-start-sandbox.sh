source ./demo.conf

cd $KAFKA_SANDBOX_HOME/kafka-edu/docs-examples/mongodb-kafka-base/

# --------------------------------------------------
# Modified from basic sandbox instructions.
# -------------------------------------------------

# Adds a line to the docker-compose.yml file to 
# open port 8083 on the Connect container
# (i.e. map port 8083 on the Connect container to host port 8083) 
# so we can use the Connect REST API locally instead of having to
# execute the commands within the Connect container itself.
# The REST API is used to add source & sink connectors.

yamlFile="docker-compose.yml"

if ! grep -q "8083:8083" "$yamlFile" ; then
  echo "Modifying $yamlFile to expose port 8083 of Kafka Connect container."
  cp $yamlFile $yamlFile.ORIGINAL
  sed -i '' 's/35000:35000\"/&\n      - \"8083:8083\"/' $yamlFile
fi

# End modifications
# --------------------------------------------------

echo 
echo "Launching Kafka Connector sandbox..."
echo 

docker-compose -p mongo-kafka up -d --force-recreate

cd .

echo
echo "To view running containers:"
echo "docker container ls"
echo

