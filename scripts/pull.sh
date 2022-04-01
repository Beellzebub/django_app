#!/bin/bash

echo "Start git pull docker config:"
cd /opt/memes || exit
git pull

echo "Start git pull application:"
cd /opt/memes/code || exit
git pull