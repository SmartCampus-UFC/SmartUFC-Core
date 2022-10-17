#!/bin/bash
#
#  curl commands to reload the data from the previous tutorial
#
#

set -e

printf "Provisioning APIs"

#
# Create services
#

curl -s -o /dev/null -X POST --url http://kong:8001/services/ --data 'name=campuquixada-orion-service' --data 'url=http://10.0.200.100:1026'
curl -s -o /dev/null -X POST --url http://kong:8001/services/ --data 'name=campusquixada-iotagent-service' --data 'url=http://10.0.200.100:4041'
curl -s -o /dev/null -X POST --url http://kong:8001/services/ --data 'name=campuspici-orion-service' --data 'url=http://10.0.10.67:1026'
curl -s -o /dev/null -X POST --url http://kong:8001/services/ --data 'name=campuspici-iotagent-service' --data 'url=http://10.0.10.67:4041'

#
# Create routes
#

curl -s -o /dev/null -X POST --url http://kong:8001/services/campusquixada-orion-service/routes --data 'paths[]=/campusquixada/orion' --data 'strip_path=true' --data 'methods[]=GET' --data 'methods[]=POST' --data 'methods[]=PUT' --data 'methods[]=PATCH' --data 'methods[]=DELETE' --data 'methods[]=OPTIONS'
curl -s -o /dev/null -X POST --url http://kong:8001/services/campusquixada-iotagent-service/routes --data 'paths[]=/campusquixada/iotagent' --data 'strip_path=true' --data 'methods[]=GET' --data 'methods[]=POST' --data 'methods[]=PUT' --data 'methods[]=PATCH' --data 'methods[]=DELETE' --data 'methods[]=OPTIONS'
curl -s -o /dev/null -X POST --url http://kong:8001/services/campuspici-orion-service/routes --data 'paths[]=/campuspici/orion' --data 'strip_path=true' --data 'methods[]=GET' --data 'methods[]=POST' --data 'methods[]=PUT' --data 'methods[]=PATCH' --data 'methods[]=DELETE' --data 'methods[]=OPTIONS'
curl -s -o /dev/null -X POST --url http://kong:8001/services/campuspici-iotagent-service/routes --data 'paths[]=/campuspici/iotagent' --data 'strip_path=true' --data 'methods[]=GET' --data 'methods[]=POST' --data 'methods[]=PUT' --data 'methods[]=PATCH' --data 'methods[]=DELETE' --data 'methods[]=OPTIONS'

#
# Configure CORS per service
#

curl -s -o /dev/null -X POST http://kong:8001/services/campusquixada-orion-service/plugins \
    --data "name=cors"  \
    --data "config.origins=*" \
    --data "config.methods=GET" \
    --data "config.methods=POST" \
    --data "config.methods=PUT" \
    --data "config.methods=PATCH" \
    --data "config.methods=DELETE" \
    --data "config.methods=OPTIONS" \
    --data "config.headers=Accept" \
    --data "config.headers=Accept-Version" \
    --data "config.headers=Content-Length" \
    --data "config.headers=Content-MD5" \
    --data "config.headers=Content-Type" \
    --data "config.headers=Host" \
    --data "config.headers=Date" \
    --data "config.headers=fiware-service" \
    --data "config.headers=fiware-servicepath" \
    --data "config.headers=X-Auth-Token" \
    --data "config.exposed_headers=X-Auth-Token" \
    --data "config.credentials=true" \
    --data "config.max_age=3600"

curl -s -o /dev/null -X POST http://kong:8001/services/campusquixada-iotagent-service/plugins \
    --data "name=cors"  \
    --data "config.origins=*" \
    --data "config.methods=GET" \
    --data "config.methods=POST" \
    --data "config.methods=PUT" \
    --data "config.methods=PATCH" \
    --data "config.methods=DELETE" \
    --data "config.methods=OPTIONS" \
    --data "config.headers=Accept" \
    --data "config.headers=Accept-Version" \
    --data "config.headers=Content-Length" \
    --data "config.headers=Content-MD5" \
    --data "config.headers=Content-Type" \
    --data "config.headers=Host" \
    --data "config.headers=Date" \
    --data "config.headers=fiware-service" \
    --data "config.headers=fiware-servicepath" \
    --data "config.headers=X-Auth-Token" \
    --data "config.exposed_headers=X-Auth-Token" \
    --data "config.credentials=true" \
    --data "config.max_age=3600"


curl -s -o /dev/null -X POST http://kong:8001/services/campuspici-orion-service/plugins \
    --data "name=cors"  \
    --data "config.origins=*" \
    --data "config.methods=GET" \
    --data "config.methods=POST" \
    --data "config.methods=PUT" \
    --data "config.methods=PATCH" \
    --data "config.methods=DELETE" \
    --data "config.methods=OPTIONS" \
    --data "config.headers=Accept" \
    --data "config.headers=Accept-Version" \
    --data "config.headers=Content-Length" \
    --data "config.headers=Content-MD5" \
    --data "config.headers=Content-Type" \
    --data "config.headers=Host" \
    --data "config.headers=Date" \
    --data "config.headers=fiware-service" \
    --data "config.headers=fiware-servicepath" \
    --data "config.headers=X-Auth-Token" \
    --data "config.exposed_headers=X-Auth-Token" \
    --data "config.credentials=true" \
    --data "config.max_age=3600"

curl -s -o /dev/null -X POST http://kong:8001/services/campuspici-iotagent-service/plugins \
    --data "name=cors"  \
    --data "config.origins=*" \
    --data "config.methods=GET" \
    --data "config.methods=POST" \
    --data "config.methods=PUT" \
    --data "config.methods=PATCH" \
    --data "config.methods=DELETE" \
    --data "config.methods=OPTIONS" \
    --data "config.headers=Accept" \
    --data "config.headers=Accept-Version" \
    --data "config.headers=Content-Length" \
    --data "config.headers=Content-MD5" \
    --data "config.headers=Content-Type" \
    --data "config.headers=Host" \
    --data "config.headers=Date" \
    --data "config.headers=fiware-service" \
    --data "config.headers=fiware-servicepath" \
    --data "config.headers=X-Auth-Token" \
    --data "config.exposed_headers=X-Auth-Token" \
    --data "config.credentials=true" \
    --data "config.max_age=3600"
