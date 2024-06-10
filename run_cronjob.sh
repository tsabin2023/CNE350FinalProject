#!/bin/bash

# source https://www.baeldung.com/linux/bandwidth-usage-monitoring
# source https://www.geeksforgeeks.org/find-command-in-linux-with-examples/#
# source https://www.geeksforgeeks.org/vnstat-command-in-linux-with-examples/#
# source Brian Huang
# code modified by Tyler Sabin


script_path="~/CNE350FinalProject/CNE350FinalBASH.sh"

cron_job="*/1 * * * * $script_path"

file_pattern="bandwidth_usage_*"

log_directory="/var/log/vnstat_logs"

echo "$cron_job" | crontab -

echo "cron job added:"

echo "$cron_job"

find /var/log/vnstat_logs -name "bandwidth_usage_*.csv" -type f -mtime 1 -exec rm {} \;

echo "log files older than 366 days have been deleted."
