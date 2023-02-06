FROM ubuntu:22.04

RUN apt update --fix-missing
RUN apt upgrade -y
RUN apt install -y git python3 python3-distutils build-essential

WORKDIR /root
COPY run_workers.sh .
RUN chmod +x run_workers.sh

ENV WORKER_CONFIG $WORKER_CONFIG
CMD ./run_workers.sh
