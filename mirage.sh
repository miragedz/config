#!/usr/bin/bash
oh=~/.oh-my-zsh
echo -e "#### Install dependency packages\n"
sudo apt update && sudo apt -y upgrade && sudo apt -y install ffmpeg micro  zsh git aria2 eza git zsh cups  v4l-utils  libz-dev php php-mbstring hostapd dnsmasq samba samba-common-bin
sudo chmod 777 /var/lib/samba/usershares
clear

sh -c "$(wget https://raw.githubusercontent.com/kingrachid2000/config/master/zh_auto.sh -O -)"

rm -rf .zshrc
echo -e "#### update .zshrc"
wget -P ~/ https://git.io/JenZH #.zshrc
wget -P ~/ https://git.io/Je8IP #p10k.zh

wget -P $oh/themes https://git.io/JenZ9
sudo fc-cache -f -v
clear
