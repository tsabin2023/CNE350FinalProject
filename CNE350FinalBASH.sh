#!/bin/bash

# source https://www.baeldung.com/linux/bandwidth-usage-monitoring
# source https://www.geeksforgeeks.org/vnstat-command-in-linux-with-examples/
# source https://www.geeksforgeeks.org/find-command-in-linux-with-examples/
# source Brian Huang
# source Nick
# code modified by Tyler Sabin


LOG="/var/log/vnstat_logs/bandwidth_usage_$(date +%Y%m%d_%I%M%S_%p).csv"

echo -n "$(date --rfc-3339=date)," >> "$LOG"

# Replace 'wlan0' with your actual network interface name, e.g., 'wlan0' for Wi-Fi
awk -v interface="wlan0" '
    $1 == interface ":" {
        RX=$2/1024/1024
        TX=$10/1024/1024
        TOTAL=RX+TX
        printf "\nRX: %.2f MiB\nTX: %.2f MiB\nTotal (RX + TX): %.2f MiB\n", RX, TX, TOTAL
    }' /proc/net/dev >> "$LOG"

find /var/log/vnstat_logs -name "bandwidth_usage_*.csv" -type f -mmin +5 -exec rm {} \;

echo "Log files older than 5 min have been removed"
