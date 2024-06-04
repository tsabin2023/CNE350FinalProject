#!/bin/bash

find /var/log/vnstat_logs -name "bandwidth_usage_*.csv" -type f -mtime 1 -exec rm {} \; 

echo "log files older than 1 day have been deleted."
