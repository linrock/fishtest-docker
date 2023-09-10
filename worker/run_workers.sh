#!/bin/bash

git clone https://github.com/glinscott/fishtest ~/fishtest

concurrency=16
num_workers=$(( ($(nproc)) / $concurrency ))
for worker in $(seq 1 $num_workers); do
  worker_dir=~/16core-worker$worker
  cp -r fishtest $worker_dir
  cd $worker_dir/worker
  taskset -c $(( ($worker - 1) * $concurrency ))-$(( $worker * $concurrency - 1 )) \
    python3 worker.py $WORKER_CONFIG --concurrency $concurrency &
  cd ~
done

wait
