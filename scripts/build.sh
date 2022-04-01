#!/bin/bash

while [ -n "$1" ]; do
  case "$1" in
    --app) shift; yml="docker-compose.app.yml";;
    --dev) shift; yml="docker-compose.dev.yml";;
    --prod) shift; yml="docker-compose.prod.yml";;
    *) echo "Unknown argument: $1";;
  esac
  shift
done

cd cd /opt/memes || exit
docker-compose -f "$yml" down
docker rm "$(docker ps -a -q)"
docker-compose -f "$yml" up --build -d
docker rmi "$(docker images -f dangling=true -q)"