# EXAMPLE #1: Retrieving Metrics from the DC/OS CLI
The DC/OS CLI can provide task level metrics to the command line.  The commands described here are useful for exploring the metrics available through DC/OS or setup a metrics feed to a third party monitoring application.

## Requirements
* A DC/OS Cluster installed and healthy

## Retrieve Node level metrics
There are two types of node level metrics, summary and detail.  The summary metrics report the CPU, Memory and available Disk.  The detail node metrics show all of the statistics tracked for a specific node.

The first step to retrieving the node level statistics is to identify the MESOS Id for a given node within the cluster as shown below:
```aidl
Marks-MacBook-Pro:weblogic-load-test markjohnson$ dcos node
   HOSTNAME        IP                         ID                     TYPE                 REGION          ZONE
  10.0.0.175   10.0.0.175  fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S5   agent            aws/us-west-2  aws/us-west-2b
  10.0.0.74    10.0.0.74   fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S2   agent            aws/us-west-2  aws/us-west-2b
  10.0.0.75    10.0.0.75   fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S4   agent            aws/us-west-2  aws/us-west-2b
  10.0.1.58    10.0.1.58   fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S8   agent            aws/us-west-2  aws/us-west-2b
  10.0.2.200   10.0.2.200  fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S3   agent            aws/us-west-2  aws/us-west-2b
  10.0.2.41    10.0.2.41   fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S7   agent            aws/us-west-2  aws/us-west-2b
  10.0.3.159   10.0.3.159  fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S9   agent            aws/us-west-2  aws/us-west-2b
  10.0.3.164   10.0.3.164  fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S6   agent            aws/us-west-2  aws/us-west-2b
  10.0.3.182   10.0.3.182  fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S1   agent            aws/us-west-2  aws/us-west-2b
  10.0.3.96    10.0.3.96   fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S0   agent            aws/us-west-2  aws/us-west-2b
  10.0.4.91    10.0.4.91   fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S10  agent            aws/us-west-2  aws/us-west-2c
master.mesos.  10.0.4.85     fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b    master (leader)  aws/us-west-2  aws/us-west-2c
```

We want to pull the metrics for the Host IP 10.0.0.175 which in this case has MESOS id fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S5.  Then to see the summary metrics enter the following command:
```aidl
Marks-MBP:dcos_scripts markjohnson$ dcos node metrics summary fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S5
CPU           MEM               DISK
0.08 (4.80%)  4.04GiB (25.76%)  2.81GiB (1.97%)
``` 

For more details you can select the metrics detail option as shown below:
```aidl
Marks-MBP:dcos_scripts markjohnson$ dcos node metrics details fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S5
NAME                       VALUE      TAGS
filesystem.inode.free      2050152    path: /dev
filesystem.inode.total     5242880    path: /var/lib
network.out.errors         0          interface: docker0
memory.buffers             0.10GiB
network.in.errors          0          interface: spartan
filesystem.inode.free      2054464    path: /sys/fs/cgroup
filesystem.inode.used      309        path: /dev
filesystem.capacity.used   0.00GiB    path: /usr/share/oem
filesystem.inode.used      1693       path: /var/lib
network.out.dropped        0          interface: docker0
load.1min                  0.06
network.in                 0.00GiB    interface: minuteman
filesystem.capacity.free   7.84GiB    path: /run
network.out.packets        781125     interface: eth0
filesystem.inode.total     32768      path: /usr/share/oem
...

(Partial list of available metrics shown above)

```

## Retrieve Task Level Metrics
To see task level metrics (elaborated more in the following 2 examples), you will first identify the task id as shown below:
```aidl
$ dcos task

NAME                           HOST         USER   STATE  ID                                                                  MESOS ID                                      REGION          ZONE
alertmanager-0-server          10.0.0.175  nobody    R    alertmanager-0-server__52692943-0c29-4de3-92da-c438e0a44fa3         fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S5   aws/us-west-2  aws/us-west-2b
grafana                        10.0.1.58    root     R    grafana.5cf9732d-f299-11e8-b919-368064a59738                        fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S8   aws/us-west-2  aws/us-west-2b
grafana-0-server               10.0.0.175   root     R    grafana-0-server__e761a293-1da7-44e2-bc76-46f6c9ba992f              fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S5   aws/us-west-2  aws/us-west-2b
marathon-lb                    10.0.4.91    root     R    marathon-lb.540dd1ca-f299-11e8-b919-368064a59738                    fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S10  aws/us-west-2  aws/us-west-2c
prometheus                     10.0.0.74    root     R    prometheus.56fe891b-f299-11e8-b919-368064a59738                     fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S2   aws/us-west-2  aws/us-west-2b
prometheus-0-agent-discovery   10.0.1.58   nobody    R    prometheus-0-agent-discovery__6aaf02b6-0efc-4f55-941a-021595ee770a  fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S8   aws/us-west-2  aws/us-west-2b
prometheus-0-server            10.0.1.58   nobody    R    prometheus-0-server__0c982a2f-8205-4465-82bd-13873689ae8f           fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S8   aws/us-west-2  aws/us-west-2b
prometheus-proxy               10.0.3.159   root     R    prometheus-proxy.56feb02c-f299-11e8-b919-368064a59738               fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S9   aws/us-west-2  aws/us-west-2b
pushgateway-0-server           10.0.2.200  nobody    R    pushgateway-0-server__208ec25f-14c9-4e9e-b1c5-d477781f2145          fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S3   aws/us-west-2  aws/us-west-2b
weblogic-benefits-app2.dept-a  10.0.3.164   root     R    dept-a_weblogic-benefits-app2.f1eefeae-f299-11e8-b919-368064a59738  fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S6   aws/us-west-2  aws/us-west-2b
```

For this example, we wish to review the summary metrics for the Weblogic Benefits app having the ID 'dept-a_weblogic-benefits-app2.f1eefeae-f299-11e8-b919-368064a59738'.


To show the summary metrics for the selected task enter the command below:
```aidl
$ dcos task metrics summary dept-a_weblogic-benefits-app2.f1eefeae-f299-11e8-b919-368064a59738
CPU           MEM              DISK
0.00 (0.00%)  0.00GiB (0.00%)  0.00GiB (0.00%)
```

To see the detailed metrics you would enter the following command:
```aidl
$ dcos task metrics details dept-a_weblogic-benefits-app2.f1eefeae-f299-11e8-b919-368064a59738
NAME                      VALUE
cpus.user_time_secs       105.29
mem.total_bytes           1011208192
cpus.nr_periods           35530
net.tx_packets            2189069
net.rx_bytes              223636457
mem.mapped_file_bytes     1368064
net.rx_packets            2412772
cpus.nr_throttled         1190
mem.file_bytes            44064768
mem.limit_bytes           2181038080
net.tx_bytes              2183835766
cpus.limit                1.10
mem.rss_bytes             957579264
cpus.system_time_secs     43.81
cpus.throttled_time_secs  185.45
mem.anon_bytes            957579264
mem.cache_bytes           44064768
```