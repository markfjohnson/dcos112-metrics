# EXAMPLE #2: Install Prometheus and Grafana and setup a sample Dashboard

## Install Prometheus and Grafan to your cluster
1. Setup Marathon-lb
You can also use Edge-LB if you are an enterprise customer.
    ```$xslt
    dcos package install --yes marathon-lb
    ```
2. Setup a Marathon-LB Proxy for Prometheus
    ```$xslt
    dcos marathon app add prometheus-marathonlb.json
    ``` 
3. Install Prometheus and Grafana packages from the catalog
    ```$xslt
    dcos package install --yes prometheus
    dcos package install --yes grafana
    ```

## Become familiar with Prometheus
1. Use the Public IP address for your cluster to access Prometheus at Port 9092, using the form ```http://{Public IP}:9092```

2. Perform a sample Prometheus Query
    ![](https://github.com/markfjohnson/dcos112-metrics/blob/master/Installation/images/Prometheus%20Query.png?raw=true)

3. Show graph Mode
    ![](https://github.com/markfjohnson/dcos112-metrics/blob/master/Installation/images/Prometheus_graph_view.png?raw=true)

## Become familiar with Grafana
1. Use the Public IP address for your cluster to access Grafana at port 9094

2. Create a Prometheus Datasource
```aidl
Marks-MacBook-Pro:Installation markjohnson$ dcos prometheus endpoints prometheus
{
  "address": ["10.0.1.199:1026"],
  "dns": ["prometheus-0-server.prometheus.autoip.dcos.thisdcos.directory:1026"],
  "vip": "prometheus.prometheus.l4lb.thisdcos.directory:9090"
}
```
* Name: Prometheus
* Type: Prometheus
* HTTP URL: http://prometheus-0-server.prometheus.autoip.dcos.thisdcos.directory:1026

2. Import the Prometheus dashboard and review metrics

3. Create a new Grafana Dashboard and setup a query
