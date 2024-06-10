# setup

note it is assumed you have a Raspberry Pi 2w already set up and running with the 64 bit OS vesion.
https://www.raspberrypi.com/documentation/computers/getting-started.html
It is also assumed you know how to access and navigate your Raspberry Pi treminal and directory.
In addition it is assumed you have sudo privileges on your account and know your sudo password.
Another assumption is that you know how to find your interface from what ifconfig displays.

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

sudo nano CNE350FinalBASH.sh - modify the interface, same line as the comment. In my case replacing it is wlan0
if this file is blank, copy and paste contents of CNE350FinalBASH.sh and change interface to yours on the line with the comment. Press control o and hit enter, then press control x. Then sudo chmod +x CNE350FinalBASH.sh

# how to run the cronjob

./run_cronjob.sh



# to verify / check your log files

cd /var/log/vnstat_logs

ls



# extra commands

crontab -l
crontab -r
find /var/log/vnstat_logs -name 'bandwidth_usage_*.csv' -type f -mtime +0 -exec rm {} \;


