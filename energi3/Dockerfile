FROM ubuntu:bionic
LABEL maintainer="Toni Ramiro <sargaxet@gmail.com"

RUN set -ex \
    && apt-get update && apt-get -y upgrade \
    && apt-get install -y ca-certificates openssl tar wget screen \
    && cd $HOME && echo "export PATH=$PATH:/root/energi3/bin" >> .bashrc \
    && echo -e "/root/.energicore3/log/*.log {\n  rotate 3\n  minsize 100M\n  copytruncate\n  compress\n  missingok\n}" > /etc/logrotate.d/energi3 \
    && wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/3.0.5/energi3-3.0.5-linux-amd64.tgz \
    && tar xvfz energi3-3.0.5-linux-amd64.tgz \
    && mv energi3-3.0.5-linux-amd64 energi3  \
    && rm energi3-3.0.5-linux-amd64.tgz \
    && mkdir -p energi3/js \
    && mkdir -p .energicore3/keystore

COPY ./wallets/* /root/.energicore3/keystore/.

WORKDIR /root
