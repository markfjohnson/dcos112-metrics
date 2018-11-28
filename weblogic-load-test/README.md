#EXAMPLE #3: Monitor a running application under load

## Pre-requisites
* A DC/OS Cluster in a healthy state with at least 5 agents and Marathon-lb also installed.
* Prometheus and Grafana have been installed on this cluster using the instructions found [here](https://github.com/markfjohnson/dcos112-metrics/tree/master/Installation).
* Install JMeter on a client machine with access to your DC/OS Cluster

## Steps to Load a legacy WebLogic application and start a simple load test
1. Install the WebLogic Benefits app using the command:
    ```
    dcos marathon app add https://raw.githubusercontent.com/markfjohnson/dcos112-metrics/master/weblogic-load-test/weblogic_demo.json
    ```

1. Confirm that the task "weblogic-benefits-app2.dept-a" has a state of "R"
    ```aidl
    dcos task | grep weblogic
 
    NAME                           HOST         USER   STATE  ID                                                                  MESOS ID                                      REGION          ZONE
    weblogic-benefits-app2.dept-a  10.0.3.164   root     R    dept-a_weblogic-benefits-app2.f1eefeae-f299-11e8-b919-368064a59738  fb3f6a7d-e14d-4aa2-9ce0-e6bf5b60176b-S6   aws/us-west-2  aws/us-west-2b
    ```

1. Startup JMeter 

    ```aidl
    jmeter -t WebLogic_Benefits_Scale_test.jmx
    ```
    Starting JMeter will result in the JMeter GUI app to start.  As part of the JMeter startuyp the process will automatically load our simple test script.
    
1. Set the Public IP
    Get the cluster's public IP address, so that you can set the Server IP address into the JMeter test plan as shown below.
    ![](https://github.com/markfjohnson/dcos112-metrics/raw/master/weblogic-load-test/images/SetPublic_servername.png)
    
1. Run the JMeter load test by pressing the Green start button.  Pressing the start button initiates the testing.  Then, click on the Summary Report optin in the test plan to see the test results.
    ![](https://github.com/markfjohnson/dcos112-metrics/raw/master/weblogic-load-test/images/jmeter_summary.png)
    
 
 ## Review DC/OS metrics for the WebLogic Benefits application in Grafana
 1. Open your browser and open the url http://{public IP}:9094.  The user id and password is admin/admin.
     ![](https://github.com/markfjohnson/dcos112-metrics/raw/master/weblogic-load-test/images/grafana_login.png)
 
 1. Import the sample dashboard for the WebLogic Benefits application
    ![](https://github.com/markfjohnson/dcos112-metrics/raw/master/weblogic-load-test/images/grafana_import.png)
    
 1. You will now be able to see just the network, memory and CPU utilization for the Benefits application under load
    ![](https://github.com/markfjohnson/dcos112-metrics/raw/master/weblogic-load-test/images/grafana_dashboard.png)