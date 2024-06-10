#!/bin/bash

# source https://www.baeldung.com/linux/bandwidth-usage-monitoring
# source Brian Huang
# code modified by Tyler Sabin

LOG=/var/log/vnstat_logs/bandwidth_usage_$(date +%Y%m%d_%I%M%S_%p).csv

echo -n "$(date --rfc-3339=date)," >> $LOG

awk '/^\s*enp0s3:/ { # UPDATE THIS, REPLACE THE INTERFACE (e.g. replace enp0s3 with your written down interface)
    RX=$2/1024/1024
    TX=$10/1024/1024
    TOTAL=RX+TX
    print "\nRX: " , RX , " MiB\n" , "TX: " , TX ," MiB\n" , "Total (RX + TX): " , TOTAL
}' /proc/net/dev >> $LOG

find /var/log/vnstat_logs -name "bandwidth_usage_*.csv" -type f -mtime +1 -exec rm {} \;

echo "log files older than 1  day/s have been deleted."
