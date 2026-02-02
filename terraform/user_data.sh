#!/bin/bash

apt update
apt install -y docker.io

systemctl start docker
systemctl enable docker

docker run -d -p 3000:3000 sierrapablo/api-test:latest
