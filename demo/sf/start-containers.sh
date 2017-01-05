#!/bin/bash

# Run Wordpress
echo "### Run Wordpress"
docker rm -f wordpress 2>/dev/null || true
docker run -d --name wordpress fhr/wordpress

# Run Varnish
echo "### Run Varnish"
docker rm -f varnish 2>/dev/null || true
