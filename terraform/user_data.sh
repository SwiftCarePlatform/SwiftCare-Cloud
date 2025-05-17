#!/bin/bash
dnf update -y

# Install Docker the correct way for Amazon Linux 2023
dnf install -y docker
systemctl enable --now docker
usermod -aG docker ec2-user

# Login to Docker Hub
echo "$DOCKER_HUB_SECRET" | docker login -u "chrisjindu" --password-stdin

# Pull and run containers
docker pull chrisjindu/frontend:latest
docker pull chrisjindu/backend:latest

docker run -d -p 80:80 chrisjindu/frontend:latest
docker run -d -p 8000:8000 chrisjindu/backend:latest