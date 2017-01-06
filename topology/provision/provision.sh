#!/bin/bash

# Update the package index & install utilities
echo "### Update the package index"
apt-get update && apt-get install httpie -y

# Install Docker
echo "### Install Docker"
wget -qO- https://get.docker.com/ | sh
usermod -aG docker ubuntu

# Build the Varnish image
echo "### Build the Varnish image"
cd /vagrant/images/varnish
docker build -t fhr/varnish .

# Build the web application image
echo "### Build the web application image"
cd /vagrant/images/wordpress
docker build -t fhr/wordpress .

# Run the web application container
echo "### Run the web application container"
docker rm -f web-app 2>/dev/null || true
docker run -d --name web-app fhr/wordpress

# Run the Varnish container
echo "### Run the Varnish container"
docker rm -f rproxy 2>/dev/null || true
docker run -d -p 80:80 \
--link web-app:backend-host \
--volumes-from web-app \
--env 'VCL_CONFIG=/data/config/varnish.vcl' \
--name rproxy million12/varnish
