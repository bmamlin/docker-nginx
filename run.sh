#!/bin/bash

# Start up three little servers
cd /docs/one
python -m SimpleHTTPServer 8080 >/dev/null 2>&1 &

cd /docs/two
python -m SimpleHTTPServer 8081 >/dev/null 2>&1 &

cd /docs/three
python -m SimpleHTTPServer 8082 >/dev/null 2>&1 &

# Start up nginx
/usr/sbin/nginx -c /nginx.conf