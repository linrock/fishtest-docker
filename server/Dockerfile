FROM ubuntu:20.04

RUN apt update --fix-missing
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt install -y \
  build-essential vim git wget curl python3 python3-pip \
  ufw git bash-completion nginx exim4 mutt curl procps pigz

# install mongodb
RUN wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | \
  tee /etc/apt/sources.list.d/mongodb-org-6.0.list
RUN apt update
RUN apt install -y mongodb-org

# set the cache size in /etc/mongod.conf
RUN sed -i 's/^#  wiredTiger:/  wiredTiger:\n    engineConfig:\n      cacheSizeGB: 1.75/' /etc/mongod.conf
# set the free cloud monitoring
RUN sed -i '/^## Enterprise-Only Options:/i\cloud:\n  monitoring:\n    free:\n      state: on\n' /etc/mongod.conf
# set the memory decommit
RUN sed -i '/^## Enterprise-Only Options:/i\setParameter:\n  tcmallocAggressiveMemoryDecommit: 1\n' /etc/mongod.conf
# setup logrotate for mongodb
RUN sed -i '/^  logAppend: true/a\  logRotate: reopen' /etc/mongod.conf

WORKDIR /root
RUN echo '' > fishtest.secret
RUN echo '' > fishtest.captcha.secret
RUN echo 'http://127.0.0.1/upload_net/' > fishtest.upload

WORKDIR /app
COPY setup.sh .
RUN git clone https://github.com/glinscott/fishtest fishtest

RUN apt install -y python3-venv
RUN pip3 install --upgrade pip setuptools wheel

ENV VENV=/app/fishtest/server/env
RUN python3 -m venv ${VENV}
RUN ${VENV}/bin/python3 -m pip install --upgrade pip setuptools wheel

WORKDIR /app/fishtest/server
RUN ${VENV}/bin/python3 -m pip install -e .

COPY nginx.fishtest.conf /etc/nginx/sites-available/fishtest.conf
RUN ln -s /etc/nginx/sites-available/fishtest.conf /etc/nginx/sites-enabled/fishtest.conf

COPY run_prod_services.sh .
# Run these after starting
# mongod --config /etc/mongod.conf
# /app/fishtest/server/env/bin/pserve production.ini http_port=6543
# nginx

EXPOSE 65432
CMD sleep infinity
