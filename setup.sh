#!/bin/sh

for CPU in /sys/devices/system/cpu/* ; do
    GOV=$CPU/cpufreq/scaling_governor
    if [ -f $GOV ] ; then
        echo performance > $GOV
        cat $GOV
    fi
done
