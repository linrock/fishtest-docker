#!/bin/bash

num_workers=$(( $(nproc) / 16 ))
for worker in $(seq 1 $num_workers); do
  git clone https://github.com/glinscott/fishtest /root/worker$worker
  cd /root/worker$worker/worker
  python3 worker.py $WORKER_CONFIG &
  cd /root
done

wait
