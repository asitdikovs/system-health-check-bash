#!/bin/bash

# ───────────────────────────────────────────────
# System Health Check Script for Linux
# Author: Aleksejs Sitdikovs
# Description: Displays CPU, memory, disk usage, and uptime.
# Logs summary to /var/log/system_health.log
# ───────────────────────────────────────────────

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Global variables
disk_usage=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk -F',' '{for(i=1;i<=NF;i++) if($i ~ /id/) print $i}' | awk '{print $1}' | cut -d. -f1)
cpu_usage=$((100 - cpu_idle))
read total used <<< $(free -m | awk '/Mem:/ {print $2, $3}')
mem_usage=$(( used * 100 / total ))

# Header
echo -e "${CYAN}\nSystem Health Check - $(date)${NC}"
echo "---------------------------------------"

# Uptime
echo -e "${CYAN}\nUptime:${NC}"
uptime

# CPU Usage
echo -e "${CYAN}\nCPU Usage:${NC}"
if [ "$cpu_usage" -ge 90 ]; then
  echo -e "${RED}\nHigh CPU usage: ${cpu_usage}%${NC}"
elif [ "$cpu_usage" -ge 60 ]; then
  echo -e "${YELLOW}\nModerate CPU usage: ${cpu_usage}%${NC}"
else
  echo -e "${GREEN}\nHealthy CPU usage: ${cpu_usage}%${NC}"
fi

# Memory Usage
echo -e "${CYAN}\nMemory Usage:${NC}"
if [ "$mem_usage" -ge 85 ]; then
  echo -e "${RED}\nHigh memory usage!: ${mem_usage}%${NC}"
elif [ "$mem_usage" -ge 60 ]; then 
  echo -e "${YELLOW}\nModerate memory usage: ${mem_usage}%${NC}"
else
  echo -e "${GREEN}\nHealthy memory usage: ${mem_usage}%${NC}"
fi

# Disk Usage
echo -e "${CYAN}\nDisk Usage:${NC}"
if [ "$disk_usage" -ge 80 ]; then
  echo -e "${RED}\nHigh disk usage!: ${disk_usage}%${NC}"
elif [ "$disk_usage" -ge 70 ]; then
  echo -e "${YELLOW}\nModerate disk usage: ${disk_usage}%${NC}"
else
  echo -e "${GREEN}\nHealthy disk usage: ${disk_usage}%${NC}"
fi

# Log to file
LOGFILE="/var/log/system_health.log"
echo "$(date): CPU=${cpu_usage}%, MEM=${mem_usage}%, DISK=${disk_usage}%" >> "$LOGFILE"
