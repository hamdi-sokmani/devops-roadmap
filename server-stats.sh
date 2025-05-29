#!/bin/bash

# This script will give the following stats:
# Total CPU usage
# Total memory usage (Free vs Used including percentage)
# Total disk usage (Free vs Used including percentage)
# Top 5 processes by CPU usage
# Top 5 processes by memory usage

# optional : os version, uptime, load average, logged in users, failed login attempts, etc..


# Get using /proc/stat
CPU_USAGE=$(top -bn1 | grep load | awk '{printf "%.2f\n", $(NF-2)}' )
echo "Total CPU usage: ${CPU_USAGE}"
echo
# Get using free -m
MEMORY_USAGE=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)", $3,$2,$3*100/$2 }')
echo "Memory usage (used/total): ${MEMORY_USAGE}"
echo
# Get using df -h
DISK_USAGE=$(df -h | awk '$NF=="/"{printf "%d/%dGB (%s)\n", $3,$2,$5}')
echo "Disk usage (used/total): ${DISK_USAGE}"
echo
# Get using ps 
echo "Top 5 processes by CPU usage"
ps aux | sort -nrk 3,3 | head -n 5 | rev | cut -d' ' -f1 | rev
echo
# Get using ps aux
echo "Top 5 processes by Memory usage"
ps aux | sort -nrk 4,4 | head -n 5 | rev | cut -d' ' -f1 | rev
echo 
# Get using uname -r
echo "os version"
uname -r
echo 
# Get using uptime
echo "server uptime"
uptime
echo 