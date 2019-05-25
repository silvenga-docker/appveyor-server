FROM ubuntu:bionic

ARG DOWLOAD_URL="https://www.appveyor.com/downloads/appveyor-server/7.0/linux/appveyor-server_7.0.2150_amd64.deb"

RUN set -xe \
    && apt-get update \
    && apt-get install -y \
    curl \
    libcap2-bin lsof sudo \
    liblttng-ust0 libcurl4 libssl1.0.0 libkrb5-3 zlib1g libicu60 \
    && curl ${DOWLOAD_URL} -o appveyor-server_amd64.deb \
    && dpkg -i appveyor-server_amd64.deb \
    && rm -f appveyor-server_amd64.deb

RUN set -xe \
    && rm -f /etc/opt/appveyor/server/appsettings.json \
    && ln -s /data/appsettings.json /etc/opt/appveyor/server/appsettings.json \
    && ls -las /etc/opt/appveyor/server/ \
    && sed -i -e "s/\/var\/opt\/appveyor\/server/\/data/" /etc/opt/appveyor/server/appsettings.json.example

COPY rootfs/* /

WORKDIR /opt/appveyor/server
ENV TERM=xterm-256color
VOLUME [ "/data" ]

CMD ["/bin/bash", "/start.sh"]