#### fishtest-docker

Containers for fishtest server and workers.


### workers

Example of starting workers on two servers. By default:
- all available cores are used
- each worker uses 16 cores with cpu pinning

```bash
SERVERS=(
  server1
  server2
)

cd worker
for server in ${SERVERS[@]}; do
  echo $server
  WORKER_CONFIG="username password" \
    docker -H ssh://$server compose up --build -d
done
```

See `worker/run_workers.sh` for core configs and cpu pinning.


### server

Use `docker compose` to start a fishtest server. A few services
need to be manually started. See `server/Dockerfile` for more info.


### License

MIT
