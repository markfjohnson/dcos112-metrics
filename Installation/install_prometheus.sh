#!/usr/bin/env bash
dcos package install --yes marathon-lb
dcos marathon app add prometheus-marathonlb.json
dcos package install --yes prometheus
dcos package install --yes grafana

