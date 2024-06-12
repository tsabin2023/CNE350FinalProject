#!/bin/bash

# Delete old CSV files

find /var/log/vnstat_logs -name 'bandwidth_usage_*.csv' -type f -mtime +0 -exec rm {} \;

echo "Old CSV files have been deleted."
