#!/bin/bash

# Log file
LOG_FILE="/home/path/to/Logfile/system_health.log" ##path to Systemlogfile
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# Thresholds 
DISK_THRESHOLD=80
MEM_THRESHOLD=80
CPU_THRESHOLD=75

# Get disk usage (%)
DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//')

# Get memory usage (%)
MEM_USAGE=$(free | grep Mem | awk '{printf("%.0f"), $3/$2 * 100}')

# Get CPU load (1 minute average)
CPU_LOAD=$(top -bn1 | grep "load average" | awk '{print $(NF-2)}' | sed 's/,//')
CPU_LOAD_INT=${CPU_LOAD%.*}  # Convert to integer

# Get uptime
UPTIME=$(uptime -p)

# Log file header
echo "[$DATE] System Health Check" >> $LOG_FILE

# Disk Check
if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    echo "WARNING: Disk usage is ${DISK_USAGE}% (threshold: ${DISK_THRESHOLD}%)" >> $LOG_FILE
else
    echo "OK: Disk usage is ${DISK_USAGE}%" >> $LOG_FILE
fi

# Memory Check
if [ "$MEM_USAGE" -ge "$MEM_THRESHOLD" ]; then
    echo "WARNING: Memory usage is ${MEM_USAGE}% (threshold: ${MEM_THRESHOLD}%)" >> $LOG_FILE
else
    echo "OK: Memory usage is ${MEM_USAGE}%" >> $LOG_FILE
fi

# CPU Check
if [ "$CPU_LOAD_INT" -ge "$CPU_THRESHOLD" ]; then
    echo "WARNING: CPU load is ${CPU_LOAD} (threshold: ${CPU_THRESHOLD})" >> $LOG_FILE
else
    echo "OK: CPU load is ${CPU_LOAD}" >> $LOG_FILE
fi

# Uptime Info
echo "Uptime: $UPTIME" >> $LOG_FILE
echo "--------------------------------------------" >> $LOG_FILE

