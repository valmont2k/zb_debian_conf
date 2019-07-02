#!/bin/bash


apt install zabbix-agent -y

cp -fr ./etc/zabbix/* /etc/zabbix/

/usr/bin/crontab -l > crontabnew
cat ./crontab/crontab >> crontabnew
/usr/bin/crontab crontabnew
