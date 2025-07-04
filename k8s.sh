#!/bin/bash

##Author Harsha

#date:28.06.25

#!/bin/bash

# Config
LOG_FILE="/Home/path/to/logfile/k8s_resource_monitor.log" ## Path to the log file
DATE=$(date "+%Y-%m-%d %H:%M:%S")
CPU_THRESHOLD=80   # In percentage
MEM_THRESHOLD=80   # In percentage

echo "[$DATE] Kubernetes Resource Monitor Start" >> "$LOG_FILE"

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "kubectl not found. Please install it." | tee -a "$LOG_FILE"
    exit 1
fi

# Namespace resource usage
echo "---- Namespace Resource Usage ----" >> "$LOG_FILE"
kubectl top namespace --no-headers 2>/dev/null | while read ns cpu mem; do
    CPU_USAGE=$(echo "$cpu" | tr -d '%')
    MEM_USAGE=$(echo "$mem" | tr -d '%MiGi')

    echo "Namespace: $ns | CPU: $cpu | Memory: $mem" >> "$LOG_FILE"

    if [[ "$CPU_USAGE" =~ ^[0-9]+$ ]] && [ "$CPU_USAGE" -ge "$CPU_THRESHOLD" ]; then
        echo "WARNING: High CPU usage in namespace '$ns' ($cpu)" >> "$LOG_FILE"
    fi

    if [[ "$MEM_USAGE" =~ ^[0-9]+$ ]] && [ "$MEM_USAGE" -ge "$MEM_THRESHOLD" ]; then
        echo "WARNING: High Memory usage in namespace '$ns' ($mem)" >> "$LOG_FILE"
    fi
done


# Node resource usage
echo "---- Node Resource Usage ----" >> "$LOG_FILE"
kubectl top nodes --no-headers 2>/dev/null | while read node cpu mem; do
    CPU_USAGE=$(echo "$cpu" | tr -d '%')
    MEM_USAGE=$(echo "$mem" | tr -d '%MiGi')

    echo "Node: $node | CPU: $cpu | Memory: $mem" >> "$LOG_FILE"

    if [[ "$CPU_USAGE" =~ ^[0-9]+$ ]] && [ "$CPU_USAGE" -ge "$CPU_THRESHOLD" ]; then
        echo "WARNING: High CPU usage on node '$node' ($cpu)" >> "$LOG_FILE"
    fi

    if [[ "$MEM_USAGE" =~ ^[0-9]+$ ]] && [ "$MEM_USAGE" -ge "$MEM_THRESHOLD" ]; then
        echo "WARNING: High Memory usage on node '$node' ($mem)" >> "$LOG_FILE"
    fi
done


# Top 5 pods by memory usage
echo "---- Top 5 Pods by Memory ----" >> "$LOG_FILE"
kubectl top pod --all-namespaces --sort-by=memory --no-headers | head -n 5 >> "$LOG_FILE"

echo "[$DATE] Monitoring Completed " >> "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"

