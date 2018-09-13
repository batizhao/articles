#! /bin/bash

current_path=`pwd`

kubectl delete  -f ${current_path}/kafka/

sleep 5

kubectl delete -f ${current_path}/zookeeper/

echo "Delete Kafka and Zookeeper finished."
