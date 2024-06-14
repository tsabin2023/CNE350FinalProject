# Setup

note it is assumed you have a Raspberry Pi 2w already set up and running with the 64 bit OS vesion.
https://www.raspberrypi.com/documentation/computers/getting-started.html
It is also assumed you know how to access and navigate your Raspberry Pi treminal and directory.
In addition it is assumed you have sudo privileges on your account and know your sudo password.
Another assumption is that you know how to find your interface from what ifconfig displays.
All commands giver are in the Raspberry Pi terminal and instructions will give proper directory.
Assumes user knows to hit enter on commands that require it and that user is vary familar with BASH and Rasbian OS for navigating and modifying files. 
Note some cammands may need sudo in front of then if they don not run properly. 

In your Raspberri Pi terminal, install Git if you have not already and copy/paste the commands.
```
git clone https://github.com/tsabin2023/CNE350FinalProject
```
```
cd CNE350FinalProject
```
Step 3. For all commands starting with sudo, you may have to type in your sudo password,
(all commands below are executed inside CNE350FinalProject directory).
```
sudo apt update

sudo apt install -y vnstat

sudo mkdir /var/log/vnstat_logs
```
You may get an alert saying you already have this file and you can confirm its existance with this command.
```
ls -ld /var/log/vnstat_logs
```
Then after confirming its existance then enter these commands. 
```
sudo chmod +x /var/log/vnstat_logs

sudo chmod o+w /var/log/vnstat_logs

sudo chmod -R +rw /var/log/vnstat_logs

sudo chmod +x CNE350FinalBASH.sh

sudo chmod +x run_cronjob.sh

sudo chmod +x delete_old_csv.sh

sudo chmod +rwx delete_old_csv.sh
```
Note you may have to replace the relative path with your absolute path in CNE350FinalBASH.sh and/or run_cronjob.sh for this to work on your Raspberry Pi 2w. 


# Modify bash script / part 1 file - the inferface
To find the interface you want to select and record, in my case it is wlan0. Note, write down your case sensative interface
```
ifconfig
```
On the next line type.
``` 
nano CNE350FinalBASH.sh
```
On the line that says.
```
awk '/^\s*enp0s3:/ { # UPDATE THIS, REPLACE THE INTERFACE (e.g. replace enp0s3 with your written down interface)
```
Replace enp0s3 with your written down interface, in my case I replace it with wlan0.

Now press.
```
control 0
```
And hit enter.

Now press.
```
control x
```
And hit enter.


# How to run the cronjob

Note this command may have to be run everytime the system is powered on or restarted.
```
cd CNE350FinalProject
```
Then.
```
./run_cronjob.sh
```
# How to run second clean up cron job
```
cd CNE350FinalProject
```
```
./delete_old_csv.sh
```
```
crontab -e
```
If promted, pick 1 and hit enter. 

Below the first cronjob copy and paste this second cronjob

*/5 * * * * ~/CNE350FinalProject/delete_old_csv.sh

Write out. 
```
control o
```
Exit. 
```
control x
```
# To verify the cronjobs are running
```
crontab -l
```

# To verify / check your log files
```
cd /var/log/vnstat_logs
```
Now that you have changed directories, enter the command below. 
```
ls
```
If you want to look at a specific file, type nano and the name of the file, e.g. nano bandwidth_usage_20240611_125901_PM.csv
and my example of the contents of the file is this.

```
024-06-11,

RX:  1028.54  MiB

 TX:  31.8216  MiB

 Total (RX + TX):  1060.36
```

To exit the file when finished.
```
control x
```
# Additional fact and optional testing
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

# Extra command/s

cd ..

If you want to remove all cron jobs
```
crontab -r
```
If you want to manully remove the cvs files this project creates that are 24hrs old and older.
```
find /var/log/vnstat_logs -name "bandwidth_usage_*.csv" -type f -mtime 1 -exec rm {} \;
```
I think this caused error
If you need to debug, this logs the enviroment of /var/log/vnstat_logs/
```
env > /var/log/vnstat_logs/cron_env.log
```
chmod o+w /var/log/vnstat_logs/cron_env.log

chmod -R +rw /var/log/vnstat_logs/cron_env.log

chmod -x /var/log/vnstat_logs/cron_env.log

maybe try 
find /var/log/vnstat_logs -name 'bandwidth_usage_*.csv' -type f -mmin +5 -exec rm {} \;

Documentation 

https://github.com/vergoh/vnstat

Kim Rhodes
