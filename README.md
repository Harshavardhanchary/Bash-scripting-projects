This repo contains Bash scripts that I have Developed in my DevOps journey So far.

1. aws-resources-list.sh

This script lists the aws resources.

Example:

````bash
  ./aws-resources-list.sh us-east-1 ec2
````
The above command lists the ec2 instace in the specified region.
Note that you have AWS-CLI istalled and configured in the machine you execute this script.


2. k8s.sh

This script when executed monitors the kubernetes resources like namespace, nodes and pods at that particular instance and generates a log file.

![alt text](<Screenshot 2025-07-01 215916.png>)

3. sys.sh

This script when executed generates a log file which contains the monitoring information of the machine.
````bash
  ./sys.sh
````

4. system-monitoring.sh

This is also a system monitoring script where you can specify which resource of the system you want to know about.
Example:
````bash
  ./system-monitoring.sh disk
````
The above command displays the disk utilisation of the machine.