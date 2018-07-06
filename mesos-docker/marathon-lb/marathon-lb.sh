#!/bin/bash
read -p "Please input the marathon-lb running port:" lbport
read -p "Please input the marathon running ip:" maraip
read -p "Please input the marathon running port:" maraport
docker run --rm -d \
  -p $lbport:9090\
  -e PORTS=9090 \
  mesosphere/marathon-lb:v1.12.2 sse \
  --marathon http://$maraip:$maraport \
  --group external