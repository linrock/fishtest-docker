FROM ubuntu:23.10

RUN apt update -y && apt upgrade -y && apt install -y \
  git vim python3 python3-distutils make g++ # clang llvm

RUN useradd --create-home --shell /bin/bash worker

WORKDIR /home/worker
COPY run_workers.sh .
RUN chmod +x run_workers.sh

USER worker
ENV WORKER_CONFIG $WORKER_CONFIG

CMD ./run_workers.sh
