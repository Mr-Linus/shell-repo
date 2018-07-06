#!/bin/bash
read -p "Please input the mesos-master's ip:" masterip
read -p "Please input the mesos-master's port:(default:5050)" masterport
if [ -z "${masterport}" ];then
	masterport=5050
fi
read -p "Please input the zookeeper's ip:" zookip
read -p "Please input the zookeeper's port:(default:2181)" zookport
if [ -z "${zookport}" ];then
	zookport=2181
fi
read -p "Please input the marathon running port:(default:8080)" maraport
if [ -z "${maraport}" ];then
  maraport=8080
fi
docker run --rm -d \
  -p $maraport:8080 \
  mesosphere/marathon:v1.6.496 \
  --master zk://$masterip:$masterport/mesos \
  --zk zk://$zookip:$zookport/marathon
