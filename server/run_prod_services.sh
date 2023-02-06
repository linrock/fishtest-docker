#!/bin/bash

mongod --config /etc/mongod.conf &
/app/fishtest/server/env/bin/pserve production.ini http_port=6543 &
(cd /app/net-server && gunicorn net_server:app --workers 4 --worker-class uvicorn.workers.UvicornWorker) &
nginx

wait -n
