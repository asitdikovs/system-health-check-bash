# System Health Check Bash Script

## Overview

This Bash script provides a simple way to monitor the health of your Linux system. It displays CPU, memory, disk usage, and system uptime in a color-coded format for easy interpretation. The script also logs a summary of the system health to `/var/log/system_health.log`.

---

## Features

- **CPU Usage**: Shows current CPU usage percentage and highlights high or moderate usage.
- **Memory Usage**: Displays memory usage as a percentage, with warnings for high or moderate usage.
- **Disk Usage**: Reports disk usage of the root filesystem and flags high or moderate usage.
- **Uptime**: Prints the system uptime.
- **Color Output**: Uses colors to indicate the health status for each metric.
- **Logging**: Appends a summary line with timestamp and usage stats to `/var/log/system_health.log`.

---

## Usage

1. **Make the script executable:**

   ```sh
   chmod +x health_check.sh
   ```

2. **Run the script:**

   ```sh
   ./health_check.sh
   ```

   > **Note:** Logging requires write permissions to `/var/log/system_health.log`. You may need to run the script with `sudo`:
   >
   > ```sh
   > sudo ./health_check.sh
   > ```

---

## Output Example

```
System Health Check - Mon Jul 21 10:00:00 UTC 2025
---------------------------------------

Uptime:
 10:00:00 up  5:00,  1 user,  load average: 0.20, 0.15, 0.10

CPU Usage:
 Healthy CPU usage: 15%

Memory Usage:
 Moderate memory usage: 65%

Disk Usage:
 Healthy disk usage: 55%
```

---

## Log File

Each run appends a line to `/var/log/system_health.log` like:

```
Mon Jul 21 10:00:00 UTC 2025: CPU=15%, MEM=65%, DISK=55%
```

---

## Requirements

- Bash shell
- Standard Linux utilities: `df`, `top`, `awk`, `free`, `uptime`

---

## License

MIT License

---
