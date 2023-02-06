#!/bin/bash

mongod --config /etc/mongod.conf &
/app/fishtest/server/env/bin/pserve production.ini http_port=6543 &
nginx

wait -n
