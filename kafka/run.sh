#! /bin/bash

current_path=`pwd`

# kubectl create -f ${current_path}/kafka/namespace.yaml

kubectl create -f ${current_path}/zookeeper/

sleep 5

kubectl create -f ${current_path}/kafka/

# sleep 5

# kubectl create -f ${current_path}/createTopics/topic-create.yaml

echo "Deploying Kafka and Zookeeper finished."

