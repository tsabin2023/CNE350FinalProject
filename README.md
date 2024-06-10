# setup

note it is assumed you have a Raspberry Pi 2w already set up and running with the 64 bit OS vesion
https://www.raspberrypi.com/documentation/computers/getting-started.html

Step 1. 
git clone https://github.com/tsabin2023/CNE350FinalProject

Step 2.
cd CNE350FinalProject

Step 3. 
(all commands below are executed inside CNE350FinalProject directory)

sudo apt update

sudo apt install -y vnstat

sudo mkdir /var/log/vnstat_logs

sudo chmod o+w /var/log/vnstat_logs

sudo chmod +x CNE350FinalBASH.sh

sudo chmod +x run_cronjob.sh


# modify bash script / part 1 file - the inferface


ifconfig - select the interface you want to record

sudo nano CNE350FinalBASH - modify the interface, same line as the comment


# how to run the cronjob

./run_cronjob.sh



# to verify / check your log files

cd /var/log/vnstat_logs

ls



# extra commands

crontab -l
crontab -r
find /var/log/vnstat_logs -name 'bandwidth_usage_*.csv' -type f -mtime +0 -exec rm {} \;


