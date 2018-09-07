#! /bin/bash

current_path=`pwd`

# kubectl create -f ${current_path}/kafka/namespace.yaml
# kubectl delete -f ${current_path}/createTopics/topic-create.yaml
# sleep 5

kubectl delete  -f ${current_path}/kafka/

sleep 5

kubectl delete -f ${current_path}/zookeeper/

echo "Delete Kafka and Zookeeper finished."

