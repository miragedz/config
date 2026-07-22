#!/usr/bin/bash
oh=~/.oh-my-zsh
echo -e "#### Install dependency packages\n"
sudo apt update && sudo apt -y upgrade && sudo apt -y install ffmpeg micro  zsh git aria2 eza git zsh cups  v4l-utils  libz-dev php php-mbstring hostapd dnsmasq samba samba-common-bin
pip install --upgrade pip
sudo npm install -g playercast
python -m pip install requests 
yes | pip install youtube-dl httpserver
sudo chmod 777 /var/lib/samba/usershares
clear

sh -c "$(wget https://raw.githubusercontent.com/kingrachid2000/config/master/zh_auto.sh -O -)"

rm -rf .zshrc
aria2c https://git.io/JenZH -d ~/ #.zshrc
aria2c https://git.io/Je8IP -d ~/ #p10k.zh

aria2c https://git.io/JenZ9 -d $oh/themes
aria2c https://git.io/Jecor -d ~/.termux #font
sudo fc-cache -f -v

chsh -s zsh
clear
dos2unix .zshrc
env zsh -l
clear
