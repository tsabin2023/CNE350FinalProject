# Introduction

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

```
Note you may have to replace the relative path with your absolute path in CNE350FinalBASH.sh for this to work on your Raspberry Pi 2w. 


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


# How to run CNE350FinalBASH.sh

You will need you absolote path to CNE350FinalProject. 
'''
pwd
'''
Here is an example of where I ran pwd and its output.
```
boxuser@UbuntuW4CNE370:~/CNE350FinalProject$ pwd

/home/vboxuser/CNE350FinalProject
```
The second line is your absolute path, so copy and paste it into a txt file editor, e.g. notepad

To add it as a cronjob
```
crontab -e
```
In the folder on the bottom line you will need to ad 5 * then your absolute path with to the BASH file, eg

```
* * * * * /home/vboxuser/CNE350FinalProject/CNE350FinalBASH.sh
```
See example below of where to place your version of the code above into your cronjob file. 
```
# Edit this file to introduce tasks to be run by cron.

# 

# Each task to run has to be defined through a single line

# indicating with different fields when the task will be run

# and what command to run for the task

# 

# To define the time you can provide concrete values for

# minute (m), hour (h), day of month (dom), month (mon),

# and day of week (dow) or use '*' in these fields (for 'any').

# 

# Notice that tasks will be started based on the cron's system

# daemon's notion of time and timezones.

# 

# Output of the crontab jobs (including errors) is sent through

# email to the user the crontab file belongs to (unless redirected).

# 

# For example, you can run a backup of all your user accounts

# at 5 a.m every week with:

# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/

# 

# For more information see the manual pages of crontab(5) and cron(8)

# 

# m h  dom mon dow   command

* * * * * /home/vboxuser/CNE350FinalProject/CNE350FinalBASH.sh

```
Write out. 
```
control o
```
Exit. 
```
control x

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

Documentation 

https://github.com/vergoh/vnstat

https://www.baeldung.com/linux/bandwidth-usage-monitoring

Kim Rhodes

Brian Huang

Nick
