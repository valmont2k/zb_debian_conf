#!/bin/bash


apt install zabbix-agent -y

cp -fr ./scripts /etc/zabbix/
cp -fr ./zabbix_agentd.conf.d /etc/zabbix/

/usr/bin/crontab -l > crontabnew
cat ./crontab/crontab >> crontabnew
/usr/bin/crontab crontabnew



sed -i 's/.*Server=127.0.0.1.*/Server=zabbix.game-forest.com/' /etc/zabbix/zabbix_agentd.conf 
sed -i 's/.*ServerActive=127.0.0.1.*/ServerActive=zabbix.game-forest.com/' /etc/zabbix/zabbix_agentd.conf 
sed -i 's/.*Hostname=Zabbix server.*/HostnameItem=system.hostname/' /etc/zabbix/zabbix_agentd.conf 
sed -i 's/.*EnableRemoteCommands=0.*/EnableRemoteCommands=1/' /etc/zabbix/zabbix_agentd.conf 


#sed -i 's/.*ШАБЛОН.*/ЗАМЕНЯЮЩАЯ_СТРОКА/' ФАЙЛ


/etc/init.d/zabbix-agent restart
