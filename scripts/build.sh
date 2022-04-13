#!/bin/bash

while [ -n "$1" ]; do
  case "$1" in
    --app) shift; opt="-f docker-compose.app.yml -p ch_app";;
    --dev) shift; opt="-f docker-compose.dev.yml -p ch_dev";;
    --prod) shift; opt="-f docker-compose.prod.yml -p ch_prod";;
    *) echo "Unknown argument: $1";;
  esac
  shift
done

if [ -n "$opt" ]; then
  echo "Stop containers:"
  cd /opt/careerhub || exit
  docker-compose "$opt" down

  echo "Delete containers:"
  docker rm "$(docker ps -a -q)"

  echo "Start application:"
  docker-compose "$opt" up --build -d

  echo "Delete old containers:"
  docker rmi "$(docker images -f dangling=true -q)"
else
  echo "Launch option not specified."
fi