#!/bin/bash

git clone https://github.com/glinscott/fishtest /root/fishtest

num_16core_workers=$(( ($(nproc) - 1 ) / 16 ))
for worker in $(seq 1 $num_16core_workers); do
  worker_dir=/root/16core-worker$worker
  cp -r fishtest $worker_dir
  cd $worker_dir/worker
  python3 worker.py $WORKER_CONFIG --concurrency 16 &
  cd /root
done

num_8core_workers=$(( ( $(nproc) - 1 - $num_16core_workers ) / 8 ))
for worker in $(seq 1 $num_8core_workers); do
  worker_dir=/root/8core-worker$worker
  cp -r fishtest $worker_dir
  cd $worker_dir/worker
  python3 worker.py $WORKER_CONFIG --concurrency 8 &
  cd /root
done
wait
