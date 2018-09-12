#!/usr/bin/env bash

DATAPATH=/opt/data

mkdir -p /opt/data/kafka/datadir-kafka-{0,1,2,3}

kubectl create -f zookeeper/

sleep 5

kubectl create -f kafka/

echo "Deploying Kafka and Zookeeper finished."
