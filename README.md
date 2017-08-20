# Telegraf Docker Image with Net-SNMP + Unifi mibs for ubnt devices

This is a modification to the excellent work done by [nuntz](https://github.com/nuntz/telegraf-snmp). This build adds the 3 MIB files required in order to get the pre-built grafana dashboard created by [waterbywind](https://grafana.com/dashboards/1486) working.

Based on:

* https://github.com/nuntz/telegraf-snmp
* https://github.com/influxdata/influxdata-docker
* https://github.com/weldpua2008/docker-net-snmp
