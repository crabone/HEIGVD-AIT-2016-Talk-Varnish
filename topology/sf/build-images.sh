#!/bin/bash

# Build the Varnish image
echo "### Build the Varnish image"
cd /vagrant/images/varnish
docker build -t fhr/varnish .

# Build the web application image
echo "### Build the web application image"
cd /vagrant/images/wordpress
docker build -t fhr/wordpress .
