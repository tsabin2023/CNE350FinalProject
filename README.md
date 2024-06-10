# setup

note it is assumed you have a Raspberry Pi 2w already set up and running with the 64 bit OS vesion.
https://www.raspberrypi.com/documentation/computers/getting-started.html
It is also assumed you know how to access and navigate your Raspberry Pi treminal and directory.
In addition it is assumed you have sudo privileges on your account and know your sudo password.
Another assumption is that you know how to find your interface from what ifconfig displays.
All commands giver are in the Raspberry Pi terminal and instructions will give proper directory.

Step 1. In your Raspberri Pi terminal.
git clone https://github.com/tsabin2023/CNE350FinalProject

Step 2.
cd CNE350FinalProject

Step 3. For all commands starting with sudo, you may have to type in your sudo password.
(all commands below are executed inside CNE350FinalProject directory)

sudo apt update

sudo apt install -y vnstat

sudo mkdir /var/log/vnstat_logs
You may get an alert saying you already have this file and can confirm its existance with 
ls -ld /var/log/vnstat_logs
Then after confirming its existance proceed to the command below. 

sudo chmod o+w /var/log/vnstat_logs

sudo chmod +x CNE350FinalBASH.sh

sudo chmod +x run_cronjob.sh


# modify bash script / part 1 file - the inferface

ifconfig - select the interface you want to record, in my case it is wlan0. Write down your case sensative interface.


# how to run the cronjob

note this command may have to be run everytime the system is powered on or restarted

cd CNE350FinalProject

then

./run_cronjob.sh

# to verify the cronjob is running

crontab -l


# to verify / check your log files

cd /var/log/vnstat_logs

now that you have changed directories, enter the command below 

ls



# extra commands

crontab -r
find /var/log/vnstat_logs -name 'bandwidth_usage_*.csv' -type f -mtime +0 -exec rm {} \;


