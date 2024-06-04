# setup

git clone https://github.com/tsabin2023/CNE350FinalProject

cd CNE350FinalProject

(all commands below are executed inside CNE350FinalProject directory)

sudo apt update

sudo apt install -y vnstat

sudo mkdir /var/log/vnstat_logs

sudo chmod o+w /var/log/vnstat_logs

sudo chmod +x CNE350FinalBASH.sh

sudo chmod +x run_cronjob.sh

sudo chmod +x ./run_cronjob.sh


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
