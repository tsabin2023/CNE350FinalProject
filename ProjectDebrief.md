Code I have tried to use running 2 cron jobs at the same time. 

CNE350FinalBASH.sh  
```
#!/bin/bash

LOG=/var/log/vnstat_logs/bandwidth_usage_$(date +%Y%m%d_%I%M%S_%p).cs

echo -n "$(date --rfc-3339=date)," >> $LOG

awk '/^\s*enp0s3:/ { # UPDATE THIS, REPLACE THE INTERFACE (e.g. replace enp0s3)

    RX=$2/1024/1024

    TX=$10/1024/1024

    TOTAL=RX+TX

    print "\nRX: " , RX , " MiB\n" , "TX: " , TX ," MiB\n" , "Total (RX + TX): " , TOTAL

}' /proc/net/dev >> $LOG
```

delete_old_csv.sh
```
#!/bin/bash

LOGFILE="/var/log/vnstat_logs/delete_old_csv.log"

echo "Script started at $(date)" >> $LOGFILE

# Delete old CSV files

find /var/log/vnstat_logs -name 'bandwidth_usage_*.csv' -type f -mtime +0 -exec rm {} \; >> $LOGFILE 2>&1

if [ $? -eq 0 ]; then

    echo "Old CSV files have been deleted successfully at $(date)" >> $LOGFILE

else

    echo "Failed to delete old CSV files at $(date)" >> $LOGFILE

fi
```

run_cronjob.sh  

```
#!/bin/bash

script_path="~/CNE350FinalProject/CNE350FinalBASH.sh"

cron_job="*/1 * * * * $script_path"

echo "$cron_job" | crontab -

echo "cron job added:"

echo "$cron_job"
```
Version that deleted but left blank files on the pi
#!/bin/bash

# version on pi that makes empty files, but deletes old files
# source https://www.baeldung.com/linux/bandwidth-usage-monitoring
# source https://www.geeksforgeeks.org/vnstat-command-in-linux-with-examples/
# source https://www.geeksforgeeks.org/find-command-in-linux-with-examples/
# source Brian Huang
# source Nick
# code modified by Tyler Sabin

LOG=/var/log/vnstat_logs/bandwidth_usage_$(date +%Y%m%d_%I%M%S_%p).csv

echo -n "$(date --rfc-3339=date)," >> $LOG

awk '/^\s*wlan0:/ { # UPDATE THIS, REPLACE THE INTERFACE (e.g. replace enp0s3 with your written down interface)
    RX=$2/1024/1024
    TX=$10/1024/1024
    TOTAL=RX+TX
    print "\nRX: " , RX , " MiB\n" , "TX: " , TX ," MiB\n" , "Total (RX + TX): " , TOTAL
}' /proc/net/dev >> $LOG

find /var/log/vnstat_logs -name "bandwidth_usage_*.csv" -type f -mmin +5 -exec rm {} \;

echo "Log files older than 5 min have been removed"
