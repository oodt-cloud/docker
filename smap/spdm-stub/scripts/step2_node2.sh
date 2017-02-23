#!/bin/sh
# node: eco-p32
# Makes this ndoe join the swarm. It needs the swarm worker token as input.

token_worker=$1
if [ $token_worker = '' ]; then
   echo "Worker token is null, exiting"
   exit -1
fi

export MANAGER_IP=172.30.4.62
sudo docker swarm join --token $token_worker $MANAGER_IP:2377