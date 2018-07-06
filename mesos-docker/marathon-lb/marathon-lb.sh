#!/bin/bash
read -p "Please input the marathon-lb running port:（default：9090）" lbport
if [ -z "${lbport}" ];then
	lbport=9090
fi
read -p "Please input the marathon running ip:" maraip
read -p "Please input the marathon running port:(default:8080)" maraport
if [ -z "${maraport}" ];then
	maraport=8080
fi
docker run --rm -d \
  -p $lbport:9090\
  -e PORTS=9090 \
  mesosphere/marathon-lb:v1.12.2 sse \
  --marathon http://$maraip:$maraport \
  --group external