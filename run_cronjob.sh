#!/bin/bash

# source https://www.baeldung.com/linux/bandwidth-usage-monitoring
# source https://www.geeksforgeeks.org/find-command-in-linux-with-examples/#
# source Brian Huang
# code modified by Tyler Sabin


script_path="~/CNE350FinalProject/CNE350FinalBASH.sh"

cron_job="*/1 * * * * $script_path"

echo "$cron_job" | crontab -

echo "cron job added:"

echo "$cron_job"
