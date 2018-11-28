# EXAMPLE #2: Install Prometheus and Grafana and setup a sample Dashboard

## Requirements
* A fully functioning and Health DC/OS Cluster
* Ports 9090 - 9094 open on your firewall

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
    Click [here](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=2ahUKEwjX4JLFxvfeAhWR3VMKHYwBC0oQFjAAegQICRAB&url=https%3A%2F%2Fprometheus.io%2Fdocs%2Fprometheus%2Flatest%2Fquerying%2Fbasics%2F&usg=AOvVaw2W69ezMe6KNw1u_5toIaPY) for more information about Prometheus queries.

3. Show graph Mode
    ![](https://github.com/markfjohnson/dcos112-metrics/blob/master/Installation/images/Prometheus_graph_view.png?raw=true)

## Become familiar with Grafana
1. Use the Public IP address for your cluster to access Grafana at port 9094.

   The user login for Grafana is **admin/admin**.
   
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
    * [Download](https://raw.githubusercontent.com/markfjohnson/dcos112-metrics/master/Installation/Prometheus%202.0%20Stats.json) the Prometheus dashboard.
    * Go in
![](https://github.com/markfjohnson/dcos112-metrics/blob/master/Installation/images/Prometheus%20Metrics.png?raw=true)

3. Create a new Grafana Dashboard and setup a query


## References
To identify the default set of DC/OS metrics available to Prometheus and Grafana connect to: https://docs.mesosphere.com/1.12/metrics/reference/
