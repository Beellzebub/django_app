#!/bin/bash

echo "Start git pull docker config:"
cd /opt/memes || exit
git reset --hard
git pull

echo "Start git pull application:"
cd /opt/memes/code || exit
git reset --hard
git pull