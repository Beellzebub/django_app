#!/bin/bash

echo "Start git pull docker config:"
cd /opt/careerhub || exit
git reset --hard
git pull

echo "Start git pull application:"
cd /opt/careerhub/code || exit
git reset --hard
git pull

chmod +x /opt/careerhub/scripts/*