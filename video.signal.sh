#!/bin/bash
#Copyright 2017-2021 Gustavo Santana
#(C) 2017-2021 Mirai Works LLC
#Desactivamos el puto cursor >P
#setterm -cursor off
sleep 2;
#set -x

#OMXPLAYER_DBUS_ADDR="/tmp/omxplayerdbus.${USER:-root}"
#OMXPLAYER_DBUS_PID="/tmp/omxplayerdbus.${USER:-root}.pid"
#export DBUS_SESSION_BUS_ADDRESS=`cat $OMXPLAYER_DBUS_ADDR`
#export DBUS_SESSION_BUS_PID=`cat $OMXPLAYER_DBUS_PID`

#Limpiamos la jodida pantalla?
#sudo sh -c “TERM=linux setterm -foreground black -clear >/dev/tty0”
TIMER="4";
TXSEC="$(($TIMER * 60))";

VIDEOPATH="/home/uslu/elements/Spots_sin_audio";

# Nombre de instancia para que no choque con la de uxmalstream
SERVICE="omxplayer2";

#Arreglo para el alpha channel del omxplayer
#Determinar resolucion de pantalla
resolution=$(tvservice -s | grep -oP '[[:digit:]]{1,4}x[[:digit:]]{1,4} ')
a="1920x1080 "
b="1280x720 "
c="720x480 "
d="320x240 "
#Asignar el valor actual si esta disponible(1)
echo "$resolution"

        if [ "$resolution" == "$a" ]
        then
                boxed="--win 0,0,1920,1080";
        elif [ "$resolution" == "$b" ]; 
        then
                boxed="--win 0,0,1280,720";
        elif [ "$resolution" == "$c" ]; 
        then
                boxed="--win 0,15,720,465";
        elif [ "$resolution" == "$d" ]; 
        then
                exit;
        fi
        echo "$boxed"

# infinite loop!
while true; do
        if ps ax | grep -v grep | grep $SERVICE > /dev/null
        then
        sleep 1;
else
        for entry in $VIDEOPATH/*
        do
        echo "start $entry" >> vflog_$(date +%Y_%m_%d).txt;
        if [[ `lsof | grep $target_fix/parallelads/pl1/` ]]
        then
        sleep 40;
        echo "espera por L activa" >> vflog_$(date +%Y_%m_%d).txt;
        fi
        if [[ `lsof | grep $target_fix/ads/` ]]
        then
        sleep 40;
        echo "espera por anuncio con audio" >> vflog_$(date +%Y_%m_%d).txt;
        fi
	    if [[ `lsof | grep /home/uslu/elements/imagenes-flotantes` ]]
        then
        sleep 40;
        echo "espera por imagen sin audio" >> vflog_$(date +%Y_%m_%d).txt;
        fi
        date >> vflog_$(date +%Y_%m_%d).txt;
        ( cmdpid="$BASHPID";
        (omxplayer --genlog --vol -8000 --layer 22 $boxed --alpha 1 --dbus_name org.mpris.AdsPlayer3.omxplayer "$entry" >> vflog_$(date +%Y_%m_%d).txt) \
        & while ! bash /home/uslu/melibs/fadein.sh;
        do
               echo "Todo listo";
               #exit;
        done
        wait)
	date >> vflog_$(date +%Y_%m_%d).txt;
	echo "Stop $entry" >> vflog_$(date +%Y_%m_%d).txt;
#        clear;
	sleep $TXSEC;
        echo "Lapso de tiempo entre anuncios $TXSEC segundos" >> vflog_$(date +%Y_%m_%d).txt;
        done
fi
done