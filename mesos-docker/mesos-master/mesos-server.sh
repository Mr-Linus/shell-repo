#!/bin/bash
read -p "Please input the mesos-master's port:(default:5050)"1 masterport
if [ -z "${masterport}" ];then
	masterport=5050
fi
read -p "Please input the zookeeper's ip:" zookip
read -p "Please input the zookeeper's port:(default:2181)" zookport
if [ -z "${zookport}" ];then
  zookport=2181
fi
docker run  -d  --restart=always\
  --name mesos-master \
  -p $masterport:5050 \
  -e MESOS_PORT=5050 \
  -e MESOS_ZK=zk://$zookip:$zookport/mesos \
  -e MESOS_QUORUM=1 \
  -e MESOS_REGISTRY=in_memory \
  -e MESOS_LOG_DIR=/var/log/mesos \
  -e MESOS_WORK_DIR=/var/tmp/mesos \
  -v "$(pwd)/log/mesos:/var/log/mesos" \
  -v "$(pwd)/tmp/mesos:/var/tmp/mesos" \
  mesosphere/mesos-master:1.5.0 --cluster=mesos