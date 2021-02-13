#!/bin/bash
#Copyright 2021 Gustavo Santana
#(C) Mirai Works LLC
#tput setab [1-7] Set the background colour using ANSI escape
#tput setaf [1-7] Set the foreground colour using ANSI escape
black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
white=`tput setaf 7`
bg_black=`tput setab 0`
bg_red=`tput setab 1`
bg_green=`tput setab 2`
bg_white=`tput setab 7`
ng=`tput bold`
reset=`tput sgr0`
#echo "${red}red text ${green}green text${reset}"

sleep 1;
SERVICE="melibs_installer_V3.1";
echo "${red}${bg_white}${ng}Comenzando instalacion...${reset}";
cd /home/uslu/;

echo "Parchando Modulos...";
  sudo service AdsPlayer stop;
  sudo service ImgPlayer stop;
  echo "Parchando Flotantes (Videos)...";
  sudo service AdsPlayer stop;
  sudo rm -rf /home/uslu/adsplayer;
  sudo rm /etc/init.d/AdsPlayer;
  sudo cp /home/uslu/melibs/AdsPlayer /etc/init.d/AdsPlayer;
  sudo chmod +x /etc/init.d/AdsPlayer;
  sudo update-rc.d AdsPlayer defaults;
  sudo systemctl enable AdsPlayer;
  sudo service AdsPlayer start;
  cd /home/uslu/;
  sleep 1;
  echo "Instalando Flotantes (Imagenes)...";
  sudo apt-get install libjpeg-dev
  cd /home/uslu/melibs/sauce/omxiv/
  make ilclient
  make
  sudo make install
  sleep 2;
  cd
  sudo cp /home/uslu/melibs/ImgPlayer /etc/init.d/ImgPlayer;
  sudo chmod +x /etc/init.d/ImgPlayer;
  sudo update-rc.d ImgPlayer defaults;
  sudo systemctl enable ImgPlayer;
  sudo service ImgPlayer start;
  cd /home/uslu/;
  sleep 1;
  echo "Actualizando sincronizador de anuncios...";
  mkdir /home/uslu/melibs/backups
  sudo cp /home/uslu/AdsSync/sync.cfg /home/uslu/melibs/backups/sync.cfg;
  cd /home/uslu/AdsSync/;
  git checkout .;
  git pull;
  sudo cp /home/uslu/melibs/backups/sync.cfg /home/uslu/AdsSync/sync.cfg;
  sleep 1;
  chmod +x /home/uslu/melibs/ssignage_sleep;
  chmod +x /home/uslu/melibs/ssimg_sleep;
