#!/bin/bash

##Author:Harsha
##Date:28.06.25

##This script is used for system monitoring 
##You can monitor services like Disk-usage,Disk-space,Processes-Running etc..

service=$1

if [ -z "$1" ]; then
 echo "Usage: $0 <metric to see>"
 exit 1
fi


case $service in 
	disk)
		echo " Disk Utilisation"
		df -h
		;;
	memory)
		echo checking memory
		free
		;;
	processes)
		echo "Processes"
		ps -aux
		;;
	network)
		echo "Checking network-Interfaces"
		ifconfig
		;;
	*)
		;;
esac

