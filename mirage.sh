#!/usr/bin/bash
oh=~/.oh-my-zsh
echo -e "#### Install dependency packages\n"
sudo apt update && sudo apt -y upgrade && sudo apt -y install ffmpeg micro  zsh git aria2 openssh git  zsh cups   v4l-utils libpq5 python-pip python-dev libssl-dev libcurl4-openssl-dev libjpeg-dev libz-dev php php-mbstring hostapd dnsmasq samba samba-common-bin
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




sleep2
mkdir -p ~/bin
aria2c https://raw.githubusercontent.com/kingrachid2000/Mobile/master/termux-url-opener -o bin/
aria2c https://gitlab.com/st42/termux-sudo/raw/master/sudo
chsh -s zsh
dos2unix ~/bin/termux-url-opener
chmod u+x ~/bin/termux-url-opener
mkdir ~/storage/shared/Youtube
mkdir -p ~/.config/youtube-dl
clear
sleep 5	
cat sudo > /data/data/com.termux/files/usr/bin/sudo
chmod 700 /data/data/com.termux/files/usr/bin/sudo
sleep 2
rm -rf /data/data/com.termux/files/usr/etc/motd
clear
dos2unix .zshrc
env zsh -l
clear
