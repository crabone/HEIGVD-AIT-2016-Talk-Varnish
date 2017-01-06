#!/bin/bash

# Run the web application container
echo "Run the web application container"
docker rm -f web-app 2>/dev/null || true
docker run -d --name web-app fhr/wordpress

# Run the Varnish container
echo "### Run the Varnish container"
docker rm -f rproxy 2>/dev/null || true
docker run -d -p 80:80 -p 6802:6802 \
--link web-app:backend-host \
--volumes-from web-app \
--env 'VCL_CONFIG=/data/config/varnish.vcl' \
--env 'VARNISH_ADMIN_LISTEN_PORT=6802' \
--env 'VARNISHD_PARAMS=-p default_ttl=30' \
--name rproxy fhr/varnish
