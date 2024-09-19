source demo.conf

mongosh --port 35001 --eval "

print('Inserting data to quickstart DB (Kafka source)')

db = db.getSiblingDB('quickstart')
db.sampleData.insertOne({'hello':'world'})

"

# Seems to be a delay here before data is available
sleep 1

mongosh --port 35001 --eval "

db = db.getSiblingDB('quickstart')

print('Reading data from topicData DB (Kafka sink)')
db.topicData.find()

"

