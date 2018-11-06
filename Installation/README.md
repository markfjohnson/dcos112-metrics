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
    * {show the screen with a sample query}
    * {Note the attributes returned from the query}
        * nodes
        * containers
        * tasks
3. Show graph Mode

## Become familiar with Grafana
1. Use the Public IP address for your cluster to access Grafana at port 9094
2. Create a Prometheus Datasource
2. Import the Prometheus dashboard and review metrics
3. Create a new Grafana Dashboard and setup a query
