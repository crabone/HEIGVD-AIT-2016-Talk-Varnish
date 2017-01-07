#!/bin/bash

# Run the web application container
echo "### Run the web application container"
docker rm -f wordpress 2>/dev/null || true
docker run -d --name wordpress fhr/wordpress

# Run the Varnish container
echo "### Run the Varnish container"
docker rm -f rproxy 2>/dev/null || true
docker run -d -p 80:80 \
--link wordpress:backend-host \
--volumes-from wordpress \
--env 'VCL_CONFIG=/data/config/varnish.vcl' \
--name rproxy fhr/varnish
