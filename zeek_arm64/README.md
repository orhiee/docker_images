
## build os/device info:
Rpi4 4GB ram
OS: 2021-05-07-raspios-buster-arm64-lite.img
OS-updates: 2022.01.13

### host OS prepred by:
#### Commands
sudo apt update
sudo apt -y upgrade
sudo apt -y autoclean
sudo apt -y autoremove
sudo apt install -y nmon atop htop iotop git
#### docker install:
curl -fsSL https://get.docker.com | sh - 

## docker build info:
Build based on: https://github.com/zeek/zeek/blob/master/docker/Dockerfile

### changes:
* added "net-tools" to install as zeek uses "ifconcig -a"

* added "run_zeek.sh" as docker image entry point.

* added threat intell feeds from https://github.com/CriticalPathSecurity/Zeek-Intelligence-Feeds
** added script to update files from github
** added cronjob (and installed cron) to run script every day 1AM

* changed, log output to json from txt

# issues:
* threat intell.log does not populate
    * if it works, it misses actual IOC hits.