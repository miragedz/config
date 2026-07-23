#!/usr/bin/bash
oh=~/.oh-my-zsh
echo -e "#### Install dependency packages\n"
sudo apt update && sudo apt -y upgrade && sudo apt -y install ffmpeg micro  zsh git aria2 eza git zsh cups  v4l-utils  libz-dev  hostapd dnsmasq samba samba-common-bin
sudo chmod 777 /var/lib/samba/usershares
clear

echo -e "#### Install Oh my zh and plugin\n"
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/plugins/zsh-history-substring-search
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/themes/powerlevel10k
clear

echo -e "#### update .zshrc"
rm -rf .zshrc
wget -P ~/ https://git.io/JenZH #.zshrc
wget -P ~/ https://git.io/Je8IP #p10k.zh
wget -P $oh/themes https://git.io/JenZ9
sudo fc-cache -f -v

echo -e "Thanks ... "
sleep 2
clear