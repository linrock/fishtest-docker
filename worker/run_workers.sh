#!/bin/bash

git clone https://github.com/glinscott/fishtest ~/fishtest

num_16core_workers=$(( ($(nproc) - 1 ) / 16 ))
for worker in $(seq 1 $num_16core_workers); do
  worker_dir=~/16core-worker$worker
  cp -r fishtest $worker_dir
  cd $worker_dir/worker
  python3 worker.py $WORKER_CONFIG --concurrency 16 &
  cd ~
done

num_12core_workers=$(( ( $(nproc) - 1 - ( $num_16core_workers * 16 ) ) / 12 ))
for worker in $(seq 1 $num_8core_workers); do
  worker_dir=~/8core-worker$worker
  cp -r fishtest $worker_dir
  cd $worker_dir/worker
  python3 worker.py $WORKER_CONFIG --concurrency 12 &
  cd ~
done

wait
