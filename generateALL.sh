#!/bin/bash +x

CHANNEL_NAME=$1
: ${CHANNEL_NAME:="mychannel"}

export TOOLS=$PWD/bin
export CONFIG_PATH=$PWD
export FABRIC_CFG_PATH=$PWD
export SHARE_PATH=/opt/share/fabric/
export DATAPATH=/opt/data


## Generates Org certs
function generateCerts (){
	CRYPTOGEN=$TOOLS/cryptogen
	$CRYPTOGEN generate --config=./crypto-config.yaml
}

function generateChannelArtifacts() {
	if [ ! -d channel-artifacts ]; then
		mkdir channel-artifacts
	fi

	CONFIGTXGEN=$TOOLS/configtxgen
 	$CONFIGTXGEN -profile TwoOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block
 	$CONFIGTXGEN -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME
	$CONFIGTXGEN -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1MSP
 	$CONFIGTXGEN -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org2MSP
# 	$CONFIGTXGEN -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org3MSP

	chmod -R 777 ./channel-artifacts && chmod -R 777 ./crypto-config

  cp -r ./chaincode ./channel-artifacts
	cp ./channel-artifacts/genesis.block ./crypto-config/ordererOrganizations/*
	mkdir -p $SHARE_PATH
	cp -r ./crypto-config $SHARE_PATH && cp -r ./channel-artifacts $SHARE_PATH

	mkdir -p $DATAPATH/{orderer,peer}
	mkdir -p $DATAPATH/orderer/orgorderer1/orderer0
	mkdir -p $DATAPATH/peer/org{1,2}/ca
	mkdir -p $DATAPATH/peer/org{1,2}/peer{0,1}/{couchdb,peerdata}
}

function generateK8sYaml (){
	python3 transform/generate.py
}

function clean () {
	rm -rf /opt/share/fabric/crypto-config/*
	rm -rf /opt/share/fabric/channel-artifacts/*
	rm -rf crypto-config
	rm -rf channel-artifacts
}

clean
generateCerts
generateChannelArtifacts
generateK8sYaml
