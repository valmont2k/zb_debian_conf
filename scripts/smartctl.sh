#!/bin/bash
# 2017/12/07 AcidVenom v1.0
# Скрипт мониторинга HDD с LLD для Zabbix (серверный вариант)

# Автообнаружение дисков
# Ключ: discovery

IFS=$'\n'
JSON="{\"data\":["
SEP=""

if [[ $2 = "discovery" ]]
then
get=`zabbix_get -s $1 -k system.run["smartctl --scan-open"] | grep "/dev/sd"`
for hdd in $get
do
DISKID=`echo $hdd | grep "/dev/sd" | sed "s/\/dev\///" | cut -c 1-3`
        if [[ `zabbix_get -s $1 -k system.run["smartctl -i /dev/$DISKID"] | grep "SMART support is: Enabled"` != "" ]]
        then
        JSON=$JSON"$SEP{\"{#DISKID}\":\"$DISKID\"}"
        SEP=", "
        fi
done
JSON=$JSON"]}"
echo $JSON

# Получение информации о дисках
# Ключи: info и attr

else
        if [[ $3 = "info" ]]
        then
        get=`zabbix_get -s $1 -k system.run["smartctl -x /dev/$2"]`
        for out in $get
        do
        echo $out
        done
        elif [[ $3 = "attr" ]]
        then
        get=`zabbix_get -s $1 -k system.run["smartctl -A /dev/$2"]`
        for out in $get
        do
        echo $out
        done
        fi
fi