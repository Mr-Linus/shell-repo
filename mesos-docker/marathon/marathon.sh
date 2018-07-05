read -p "Please input the mesos-master's ip:" masterip
read -p "Please input the mesos-master's port:" masterport
read -p "Please input the zookeeper's ip:" zookip
read -p "Please input the zookeeper's port:" zookport
read -p "Please input the marathon running port:" maraport
docker run --rm -d \
  -p $maraport:8080 \
  mesosphere/marathon:v1.6.496 \
  --master zk://$masterip:$masterport/mesos \
  --zk zk://$zookip:$zookport/marathon
