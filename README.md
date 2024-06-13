# setup

note it is assumed you have a Raspberry Pi 2w already set up and running with the 64 bit OS vesion.
https://www.raspberrypi.com/documentation/computers/getting-started.html
It is also assumed you know how to access and navigate your Raspberry Pi treminal and directory.
In addition it is assumed you have sudo privileges on your account and know your sudo password.
Another assumption is that you know how to find your interface from what ifconfig displays.
All commands giver are in the Raspberry Pi terminal and instructions will give proper directory.
Assumes user knows to hit enter on commands that require it and that user is vary familar with BASH and Rasbian OS for navigating and modifying files. 
Note some cammands may need sudo in front of then if they don not run properly. 

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

sudo chmod -R +rw /var/log/vnstat_logs

sudo chmod +x CNE350FinalBASH.sh

sudo chmod +x run_cronjob.sh

sudo chmod +x delete_old_csv.sh

Note you may have to replace the relative path with your absolute path in CNE350FinalBASH.sh and/or run_cronjob.sh for this to work on your Raspberry Pi 2w. 


# modify bash script / part 1 file - the inferface

ifconfig - select the interface you want to record, in my case it is wlan0. Write down your case sensative interface. 

On the next line type
``` 
nano CNE350FinalBASH.sh
```
On the line that says
```
awk '/^\s*enp0s3:/ { # UPDATE THIS, REPLACE THE INTERFACE (e.g. replace enp0s3 with your written down interface)
```
replace enp0s3 with your written down interface, in my case I replace it with wlan0

Now press
```
control 0
```
And hit enter

Now press
```
control x
```
And hit enter


# how to run the cronjob

note this command may have to be run everytime the system is powered on or restarted

cd CNE350FinalProject

then

./run_cronjob.sh

# how to run second clean up cron job

cd CNE350FinalProject

./delete_old_csv.sh

crontab -e

if promted, pick 1 and hit enter. 

below the first cronjob copy and paste

*/1 * * * * ~/CNE350FinalProject/delete_old_csv.sh

write out control o

exit control x

# to verify the cronjobs are running

crontab -l


# to verify / check your log files

cd /var/log/vnstat_logs

now that you have changed directories, enter the command below 

ls

if you want to look at a specific file, type nano and the name of the file, e.g. nano bandwidth_usage_20240611_125901_PM.csv

and my example of the contents of the file is this.

```
024-06-11,

RX:  1028.54  MiB

 TX:  31.8216  MiB

 Total (RX + TX):  1060.36
```

Press control and x to exit the file when finished. 

The unit of measurement is MiB stands for Mebibyte and is equal to 2^20 bytes, or 1,048,576 bytes. This is different than Megabyte (MB), which is equal to 10^6 bytes, or 1,000,000 bytes.

RX stands for recieving, so in this context, it is the download rate.
TX stands for transmit, which in this context is the upload rate. 

If you want a list of the first 10 files
```
ls -1 /var/log/vnstat_logs | head -n 10
```

If you want a list of the last 10 files
```
ls -1 /var/log/vnstat_logs | tail -n 10
```

# extra command/s

If you want to remove all cron jobs
```
crontab -r
```
If you want to manully remove the cvs files this project creates that are 24hrs old and older.
```
find /var/log/vnstat_logs -name "bandwidth_usage_*.csv" -type f -mtime 1 -exec rm {} \;
```
If you need to debug, this logs the enviroment of /var/log/vnstat_logs/
```
env > /var/log/vnstat_logs/cron_env.log
```
chmod o+w /var/log/vnstat_logs/cron_env.log

Documentation 

https://github.com/vergoh/vnstat

Kim Rhodes
