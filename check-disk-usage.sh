#!/bin/bash -ex

declare -i disk_usage=`df | grep /dev/sda | awk {'print $5'} | cut -d'%' -f1`
declare -i fc_slave_usage=`ssh ift@fc 'df | grep /dev/sda' | awk {'print $5'} | cut -d'%' -f1`
declare -i iscsi_slave_usage=`ssh ift@iscsi 'df | grep /dev/sda' | awk {'print $5'} | cut -d'%' -f1`

if [ "$disk_usage" -gt "40" ]; then
    echo "Master node Disk usage $disk_usage%, it's over 40%, please check!"
    exit -1
else
    echo "Master node Disk usage $disk_usage%"
fi

if [ "$fc_slave_usage" -gt "40" ]; then
    echo "FC Slave    Disk usage $fc_slave_usage%, it's over 40%, please check!"
    exit -2
else
    echo "FC Slave    Disk usage $fc_slave_usage%"
fi

if [ "$iscsi_slave_usage" -gt "40" ]; then
    echo "ISCSI Slave Disk usage $iscsi_slave_usage%, it's over 40%, please check!"
    exit -3
else
    echo "ISCSI Slave Disk usage $iscsi_slave_usage%"
fi

exit 0

