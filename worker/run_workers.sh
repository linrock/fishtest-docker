#!/bin/bash

git clone https://github.com/glinscott/fishtest ~/fishtest

num_16core_workers=$(( ($(nproc)) / 16 ))
for worker in $(seq 1 $num_16core_workers); do
  worker_dir=~/16core-worker$worker
  cp -r fishtest $worker_dir
  cd $worker_dir/worker
  taskset -c $(( ($worker - 1) * 16 ))-$(( $worker * 16 - 1 )) \
    python3 worker.py $WORKER_CONFIG --concurrency 16 &
  cd ~
done

wait
