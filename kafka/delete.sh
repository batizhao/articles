#! /bin/bash

current_path=`pwd`

kubectl delete  -f ${current_path}/kafka/

sleep 5

kubectl delete -f ${current_path}/zookeeper/

sleep 5

rm -rf /opt/data/kafka/datadir-kafka-{0,1,2,3}/

echo "Delete Kafka and Zookeeper finished."
