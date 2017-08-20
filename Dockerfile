FROM nuntz/telegraf-snmp

COPY UBNT-FROGFOOT-RESOURCES-MIB.mib /usr/share/snmp/mibs/
COPY UBNT-MIB /usr/share/snmp/mibs/
COPY UBNT-UniFi-MIB /usr/share/snmp/mibs/
