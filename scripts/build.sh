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

if [ -n "$yml" ]; then
  echo "Stop containers."
  cd /opt/memes || exit
  docker-compose -f "$yml" down

  echo "Delete containers."
  docker rm "$(docker ps -a -q)"

  echo "Start application."
  docker-compose -f "$yml" up --build -d

  echo "Delete old containers ."
  docker rmi "$(docker images -f dangling=true -q)"
else
  echo "Launch option not specified."
fi