#!/bin/sh -x
/system/bin/mpdclnt 1 1
/system/bin/mpdclnt 2 1
/system/bin/mpdclnt 3 1
echo "ondemand" >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
