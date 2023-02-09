FROM ubuntu:22.04

COPY apt-sources.list /etc/apt/sources.list
RUN apt update --fix-missing
RUN apt upgrade -y
RUN apt install -y git vim python3 python3-distutils make g++

RUN useradd --create-home --shell /bin/bash worker

WORKDIR /home/worker
COPY run_workers.sh .
RUN chmod +x run_workers.sh

USER worker
ENV WORKER_CONFIG $WORKER_CONFIG

CMD ./run_workers.sh
