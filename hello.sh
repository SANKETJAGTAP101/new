#!/bin/bash

# Function to check CPU usage
check_cpu_usage() {
    echo "=== CPU USAGE ==="
    mpstat | awk '/all/ {print "CPU Usage: " 100-$12"%"}'
    echo
}

# Function to check memory usage
check_memory_usage() {
    echo "=== MEMORY USAGE ==="
    free -h | awk '/Mem:/ {print "Used: "$3", Free: "$4}'
    echo
}

# Function to check disk usage
check_disk_usage() {
    echo "=== DISK USAGE ==="
    df -h --output=source,pcent | grep '^/' | while read line; do
        echo "$line"
    done
    echo
}

# Function to check network connectivity
check_network_connectivity() {
    echo "=== NETWORK CONNECTIVITY ==="
    ping -c 4 google.com > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Network is up"
    else
        echo "Network is down"
    fi
    echo
}

# Main script execution
echo "System Health Check"
echo "==================="
check_cpu_usage
check_memory_usage
check_disk_usage
check_network_connectivity
echo "Health check complete!"
