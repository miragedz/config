#!/bin/bash
oh=~/.oh-my-zsh
echo -e "#### Install dependency packages\n"
sudo apt update && sudo apt -y upgrade && sudo apt -y install ffmpeg python aria2 openssh git ncurses-utils zsh cups nano mc apache2 v4l-utils libmariadbclient18 libpq5 python-pip python-dev libssl-dev libcurl4-openssl-dev libjpeg-dev libz-dev php php-mbstring hostapd dnsmasq WiringPi samba samba-common-bin
pip install --upgrade pip
python -m pip install requests
yes | pip install youtube-dl
clear
#oh my zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git $oh
git clone https://git.io/vo09x $oh/plugins/zsh-syntax-highlighting
git clone https://git.io/vbNux $oh/plugins/zsh-autosuggestions
rm -rf .zshrc
echo -e ".zshrc && termux-url-opener"
sleep2
mkdir -p ~/bin
aria2c https://git.io/JeZxr #install ohmyzh
aria2c https://raw.githubusercontent.com/kingrachid2000/Mobile/master/termux-url-opener -o bin/aria2c https://raw.githubusercontent.com/kingrachid2000/Mobile/master/termux-url-opener -o bin/termux-url-opener
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
