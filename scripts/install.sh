#!/bin/bash

project_dir="$HOME/project_src"
docker_pkg="docker-ce"
compose_pkg="docker-compose"
git_pkg="git"
docker_key_url="https://download.docker.com/linux/ubuntu/gpg"
docker_repo_url="https://download.docker.com/linux/ubuntu"
project_repo_url="https://github.com/Beellzebub/django_app"

function docker_install {
  if ! dpkg -s "$1" &> /dev/null ; then
    echo "$1 not installed."
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL "$2" | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] $3 $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli
    echo "install $1 done."
  else
    echo "$1 installed."
  fi
}

function compose_install {
  if ! dpkg -s "$1" &> /dev/null ; then
    sudo apt-get install "$1"
  else
    echo "$1 installed."
  fi
}

function git_install {
  if ! dpkg -s "$1" &> /dev/null ; then
    echo "$1 not installed."
    sudo apt-get update
    if sudo apt-get install -y "$1" ; then
      echo "install $1 done."
    fi
  else
    echo "$1 installed."
  fi
}

function git_clone {
  if [[ ! -d $2 ]] ; then
    mkdir "$2"
    git clone "$1" "$2"
    echo "Project cloned in $2."
  else
    echo "$2 exist."
  fi
}

docker_install $docker_pkg $docker_key_url $docker_repo_url
compose_install $compose_pkg
git_install $git_pkg
git_clone $project_repo_url "$project_dir"

chmod +x "$project_dir/scripts/entrypoint.dev.sh"
chmod +x "$project_dir/scripts/entrypoint.prod.sh"