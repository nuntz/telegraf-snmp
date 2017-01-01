# Based on https://github.com/weldpua2008/docker-net-snmp
FROM telegraf

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
