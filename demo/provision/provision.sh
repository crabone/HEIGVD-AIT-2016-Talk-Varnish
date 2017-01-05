#!/bin/bash

# Update the package index
echo "Update the package index"
apt-get update

# Install Docker
echo "Install Docker"
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
