## fishtest-docker

Linux containers for running
[fishtest](https://tests.stockfishchess.org/)
[server](https://github.com/official-stockfish/fishtest/wiki/Fishtest-server-setup)
 and
[workers](https://github.com/official-stockfish/fishtest/wiki/Running-the-worker).


### workers

Example of how to start fishtest workers on a few servers:

```bash
SERVERS=(
  server1
  server2
  server3
)

cd worker
for server in ${SERVERS[@]}; do
  echo $server
  WORKER_CONFIG="username password" \
    docker -H ssh://$server compose up --build -d
done
```

By default:

- all available cpu cores are used
- each worker uses 16 cores with cpu pinning
- workers connect to the official fishtest server

See `worker/run_workers.sh` for core configs and cpu pinning.

See the list of [fishtest worker parameters](https://github.com/official-stockfish/fishtest/wiki/Running-the-worker#worker-parameters) for more worker params other than username/password.


### server

Use `docker compose` to start a fishtest server. A few services
need to be manually started. See `server/Dockerfile` for more info.


### License

MIT
