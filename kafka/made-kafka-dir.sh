#!/usr/bin/env bash

DATAPATH=/opt/data

rm -rf   $DATAPATH/kafka
mkdir -p $DATAPATH/kafka/datadir-kafka-{0,1,2,3}

