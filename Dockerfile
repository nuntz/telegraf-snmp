# Based on https://github.com/influxdata/influxdata-docker
# and https://github.com/weldpua2008/docker-net-snmp
FROM buildpack-deps:trusty-curl

RUN export  DEBIAN_FRONTEND=noninteractive && \
    export UBUNTU_RELEASE=$(lsb_release  -sc || cat /etc/*-release|grep -oP  'CODENAME=\K\w+$'|head -1) &&\
    set -x &&\
    echo "deb http://archive.ubuntu.com/ubuntu/ ${UBUNTU_RELEASE}-security multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu/ ${UBUNTU_RELEASE}-security multiverse" >> /etc/apt/sources.list && \
    echo "deb http://archive.ubuntu.com/ubuntu/ ${UBUNTU_RELEASE} multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu/ ${UBUNTU_RELEASE} multiverse" >> /etc/apt/sources.list && \
    echo "removing duplicated strings from /etc/apt/sources.list" && \
    awk '!x[$0]++' /etc/apt/sources.list > /tmp/sources.list && \
    cat /tmp/sources.list > /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y install snmp snmpd snmp-mibs-downloader && \
    rm -r /var/lib/apt/lists/*

RUN gpg \
    --keyserver hkp://ha.pool.sks-keyservers.net \
    --recv-keys 05CE15085FC09D18E99EFB22684A14CF2582E0C5

ENV TELEGRAF_VERSION 1.1.2
RUN wget -q https://dl.influxdata.com/telegraf/releases/telegraf_${TELEGRAF_VERSION}_amd64.deb.asc && \
    wget -q https://dl.influxdata.com/telegraf/releases/telegraf_${TELEGRAF_VERSION}_amd64.deb && \
    gpg --batch --verify telegraf_${TELEGRAF_VERSION}_amd64.deb.asc telegraf_${TELEGRAF_VERSION}_amd64.deb && \
    dpkg -i telegraf_${TELEGRAF_VERSION}_amd64.deb && \
    rm -f telegraf_${TELEGRAF_VERSION}_amd64.deb*

EXPOSE 8125/udp 8092/udp 8094

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["telegraf"]
