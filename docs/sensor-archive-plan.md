# Sensor data: replace InfluxDB with a file archive

Started 2026-10-01. Delete this file when done.

## Goal

Free ~400–500 MB RAM on haukkakallio (3 GB VM) by dropping InfluxDB and
mqtt-to-db-sender-influxdb. Sensor data no longer needs interactive queries, only
long-term storage for possible later analysis.

## Decisions

- No database. Archive raw MQTT messages (`/sensor/#`) as compressed daily files.
- Archiver is a small native app (Go or Rust), run with `docker-app`. Persistent MQTT
  session so restarts don't lose messages.
- Archive is backed up by the existing duplicacy job.
- InfluxDB history (2017→, ~15 GB) is exported once to a portable format.
- Later analysis happens offline (e.g. DuckDB), nothing on the server.
- Live view stays in sensor-ui. Grafana + Prometheus stay for server dashboards.

## Steps

- [x] 1. Build and deploy the archiver alongside InfluxDB
      ([chacal/sensor-archiver](https://github.com/chacal/sensor-archiver), deployed
      2026-10-01 to /srv/sensor-archive)
- [ ] 2. Run both in parallel ~2 weeks; check the archive is complete and its size
  - [ ] Check compressed daily file size (`ls -l /srv/sensor-archive/2026/*.zst`)
        against the raw size (~70 MB/day at ~4 msg/s) and project yearly growth
- [ ] 3. Export InfluxDB history and spot-check it against InfluxDB
- [ ] 4. Remove InfluxDB, mqtt-to-db-sender-influxdb and the InfluxDB-based Grafana
      dashboards (freya, nihtimaki, sensors) from the playbook and the host
- [ ] 5. Measure memory and disk before/after

## Notes

- Tried TSI index on 2026-10-01: memory got worse (532 small weekly shards), rolled
  back to inmem.
