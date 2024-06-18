# Intended functionality

Use a GUI, script/s, and/or a program to monitor and record my upload and download rate to trouble shoot internet connectivity issues on a Raspberry Pi 2w.

Then report the results to my internet provider to debug my reduced internet speeds. 

# Goals

Primary, was to install something that recorerded my bandwidth for later use.

Secondary, was to write a script to install and run the program so it would be automated and easy for others to do.

Tertiary, was to automate the script activation so the user would not have to run it manually at the time periods desired.

#  What was accomplished

After many, many hours of coding and debugging, I was able to accomplish all of my goals.

#  What was a struggle point or obstacle

I thought this project would be easy, but instead I had to overcome many challenges. 
The first was that my Pi ran GUI's vary slowly, so I had to learn what vnstat was in order to record the bandwidth from the terminal.

My code automation files would only run manually and I tried having a file run another file, but the automation would only run part of my file, so I split it into two files. When I tried running two automation files in crontab, only one would run. Running them in different orders did not work.

I believe this did not work because both files were trying to access the same file at the same time, so I offset when the files would run. This also did not fix the issue.

Then I tried running one file and manully putting only that file in crontab and finally the cronjob ran.

My next issue was that it only worked on my Ubuntu maching, but not my Raspberry Pi.

Note, I had to learn to use absolote paths for commands, vnstat, and crontb for cronjobs to work.

This led me to understanding the syntax differnces between the two operating systems and I had to rewrite some of my code. 
After that, the script ran smoothly.

Code below is one of the three file iterations that I tried at the same time. My intent was running two cron jobs at the same time, with a third file.

### Contents of CNE350FinalBASH.sh below

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

### Contents of delete_old_csv.sh below

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

### Contents of run_cronjob.sh below

```
#!/bin/bash

script_path="~/CNE350FinalProject/CNE350FinalBASH.sh"

cron_job="*/1 * * * * $script_path"

echo "$cron_job" | crontab -

echo "cron job added:"

echo "$cron_job"
```

### Contents of CNE350FinalBASH.sh improved combinng the other files but not Raspberry Pi compatiable

```
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
```

## If you pivoted to something else during the project, explain each iteration of goals and accomplishments from beginning to end

Luckily I did not have to change to a different project though I had to look at the project a different way. First being that the GUI programs to accomplish my goal could not run on a Raspberry Pi 2w.

I then wanted to code everything myself, but quickly realized that there was not going to be enough time to accomplish this.

The next was that I needed to find a terminal program to run the bandwidth.

Vnsat could not do all of my goals by itself, so I had to write script/s in order to meet them. 

The big lesson was finding the simplest way to accomplish my goals, which were to do some manual commands to get the script started and to only use one script to reduce errors.
