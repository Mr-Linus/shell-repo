read -p "Please input the mesos-master's port:" masterport
read -p "Please input the zookeeper's ip:" zookip
read -p "Please input the zookeeper's port:" zookport
docker run  -d  --rm \
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