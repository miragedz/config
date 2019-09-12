export ZSH="/home/pi/.oh-my-zsh"
ZSH_THEME="gnzh"
plugins=( git cp pip zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
alias i="sudo apt install"
alias r="sudo apt remove"
alias u="sudo apt-get autoremove && sudo dpkg --configure -a && sudo apt -f install && sudo apt-get --fix-broken install && sudo apt dist-upgrade && sudo apt update && sudo pip install --upgrade pip"
alias ..="cd .."
alias ...="cd ../.."
alias c='clear'
alias r='env zsh -l'
alias cp="cpv --progress"
alias phpWeb="php -S localhost:5000"
alias ng80="killall ngrok && sed -i 's/8765/80/g' /home/mirage/.ngrok2/ngrok.yml && ngrok start --all"
alias ng8765="killall ngrok && sed -i 's/80/8765/g' /home/mirage/.ngrok2/ngrok.yml && ngrok start --all"
alias m='sudo mcedit'
alias raspi='~/.config/monitor.sh -a'
alias scan='sudo iwlist wlan0 scan | grep SSID'
mkcd () { mkdir -p -- "$1" && cd -P -- "$1" }
web () { ssh -R 80:localhost:"$1" ssh.localhost.run }
net () { sudo netstat -tlp | grep -E ""$1"" }
d="/home/mirage/Downloads"
usr='/usr'

#https://www.tecmint.com/share-files-over-a-local-network-in-linux/
