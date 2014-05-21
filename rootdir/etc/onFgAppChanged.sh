#!/system/bin/sh
# Copyright (c) 2012, Code Aurora Forum. All rights reserved.
#

PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH
LIST_FILE=/etc/blist.conf
FILES=`cat $LIST_FILE`
fg_app_prop=`getprop sys.foregroundapp`
bchmode=`getprop sys.thermald.bchmode`
thermald_mode=`getprop sys.thermald.mode`
ultimate_mode=`getprop sys.ultimate.mode.enabled`
thermald_disabled=`getprop sys.thermald.disabled`
pad_mode=`getprop sys.config.resolution`
bFound=0
fg_app=$fg_app_prop
next_thermald_mode=0
#echo "onFgAppChanged"
for name in $FILES
do
        fg_app_temp=${fg_app:0:${#name}}
        #echo $fg_app_temp
        if [ "$name"x = "${fg_app_temp}"x ]; then
		bFound=1
		break
        fi
done
#echo "bFOund=$bFound"
if [ "$bchmode"x = "1"x ]; then
        if [ "$bFound"x = "0"x ]; then
                echo "setprop sys.thermald.bchmode 0"
                setprop sys.thermald.bchmode 0
                bchmode=0
        fi	
else
        if [ "$bFound"x = "1"x ]; then
                echo "setprop sys.thermald.bchmode 1"
                setprop sys.thermald.bchmode 1
		bchmode=1
        fi
fi 

#echo "thermald_mode=$thermald_mode"
#echo "bchmode=$bchmode"
#echo "ultimate_mode=$ultimate_mode"
if [ "$thermald_disabled"x = "1"x ]; then

        next_thermald_mode=3

elif [ "$bchmode"x = "1"x ] || [ "$ultimate_mode"x = "1"x ]; then

        next_thermald_mode=2

elif [ "$pad_mode"x = "2"x ]; then

        next_thermald_mode=1

else
        next_thermald_mode=0
fi


if [ ! "$thermald_mode"x = "$next_thermald_mode"x ]; then
                echo "need to restart thermald"
                stop thermald
                start thermald
fi

exit 0
