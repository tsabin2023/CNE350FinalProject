I thought this project would be easy, but instead I had to overcome many challenges. 
The first was that my Pi ran GUI's vary slowly, so I had to learn what vnstat was in order to record the bandwidth from the terminal.

My code automation files would only run manually and I tried having a file run another file, but the automation would only run part of my file, so I split it into two files. When I tried running two automation files in crontab, only one would run. Running them in different orders did not work.

I believe this did not work because both files were trying to access the same file at the same time, so I offset when the files would run. This also did not fix the issue.

Then I tried running one file and manully putting only that file in crontab and finally the cronjob ran.

My next issue was that it only worked on my Ubuntu maching, but not my Raspberry Pi.

This led me to understanding the syntax differnces between the two operating systems and I had to rewrite some of my code. 
After that, the script ran smoothly.

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
