#!/bin/bash

echo "Start git pull docker config:"
cd /opt/careerhub || exit
git reset --hard
git pull

echo "Start git pull application:"
cd /opt/careerhub/code/backend || exit
git reset --hard
git pull

echo "Start git pull application:"
cd /opt/careerhub/code/frontend || exit
git reset --hard
git pull

chmod +x /opt/careerhub/scripts/*
chmod +x /opt/careerhub/backend/sh/*