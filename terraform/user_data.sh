#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# Docker Hub login and container setup
echo "${DOCKER_HUB_SECRET}" | docker login -u "${DOCKER_HUB_USERNAME}" --password-stdin

# Pull and run containers
docker pull ${DOCKER_HUB_USERNAME}/frontend:latest
docker pull ${DOCKER_HUB_USERNAME}/backend:latest

docker run -d -p 80:80 ${DOCKER_HUB_USERNAME}/frontend:latest
docker run -d -p 8000:8000 ${DOCKER_HUB_USERNAME}/backend:latest
