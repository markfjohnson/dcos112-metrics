#!/usr/bin/env bash
# Add the Edge-LB Repository to DC/OS
dcos package install dcos-enterprise-cli --yes
dcos package repo add --index=0 edgelb-pool https://downloads.mesosphere.com/edgelb-pool/v1.2.1/assets/stub-universe-edgelb-pool.json
dcos package repo add --index=0 edgelb https://downloads.mesosphere.com/edgelb/v1.2.1/assets/stub-universe-edgelb.json

# Setup the Edge-LB Security
dcos security org service-accounts keypair edge-lb-private-key.pem edge-lb-public-key.pem

dcos security org service-accounts create -p edge-lb-public-key.pem -d "Edge-LB service account" edge-lb-principal
dcos security org service-accounts show edge-lb-principal

dcos security org users grant edge-lb-principal dcos:adminrouter:service:marathon full
dcos security org users grant edge-lb-principal dcos:adminrouter:package full
dcos security org users grant edge-lb-principal dcos:adminrouter:service:edgelb full
dcos security org users grant edge-lb-principal dcos:service:marathon:marathon:services:/dcos-edgelb full
dcos security org users grant edge-lb-principal dcos:mesos:master:endpoint:path:/api/v1 full
dcos security org users grant edge-lb-principal dcos:mesos:master:endpoint:path:/api/v1/scheduler full
dcos security org users grant edge-lb-principal dcos:mesos:master:framework:principal:edge-lb-principal full
dcos security org users grant edge-lb-principal dcos:mesos:master:framework:role full
dcos security org users grant edge-lb-principal dcos:mesos:master:reservation:principal:edge-lb-principal full
dcos security org users grant edge-lb-principal dcos:mesos:master:reservation:role full
dcos security org users grant edge-lb-principal dcos:mesos:master:volume:principal:edge-lb-principal full
dcos security org users grant edge-lb-principal dcos:mesos:master:volume:role full
dcos security org users grant edge-lb-principal dcos:mesos:master:task:user:root full
dcos security org users grant edge-lb-principal dcos:mesos:master:task:app_id full

dcos security secrets create-sa-secret --strict edge-lb-private-key.pem edge-lb-principal dcos-edgelb/edge-lb-secret
dcos security org groups add_user superusers edge-lb-principal

dcos package search edge
dcos package install --options=edge-lb-options.json edgelb --yes
dcos edgelb create prometheus-edgelb.json
dcos edgelb list
dcos edgelb status edgelb-kubernetes-cluster-proxy-basic
dcos task exec -it edgelb-pool-0-server curl ifconfig.co
