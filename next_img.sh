#!/bin/bash
#Copyright 2018-2021 Gustavo Santana
#(C) Mirai Works LLC
#
if pgrep -x "omxiv" > /dev/null
then
    echo "Running" >> log_$(date +%Y_%m_%d).txt;
    /home/uslu/melibs/ssimg_sleep 40;
    sudo killall omxiv;
else
    echo "Stopped" >> log_$(date +%Y_%m_%d).txt;
fi


