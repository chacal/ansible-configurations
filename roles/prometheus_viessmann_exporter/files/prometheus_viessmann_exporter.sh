#!/bin/bash
while true; do
/usr/bin/vclient -h localhost:3002 -f /etc/prometheus-viessmann-exporter/commands.txt -t /etc/prometheus-viessmann-exporter/viessmann.prom.tpl | /usr/bin/sponge /var/lib/prometheus/node-exporter/viessmann.prom
sleep 25
done