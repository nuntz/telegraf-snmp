# Telegraf and Net-SNMP

Telegraf is an agent for collecting metrics and writing them to InfluxDB or other outputs. The reason why I created this repository is that the official one does not include the SNMP tools, necessary for `input.snmp` input plugin.

Based on:

* https://github.com/influxdata/influxdata-docker
* https://github.com/weldpua2008/docker-net-snmp

