export ZSH=/root/.oh-my-zsh
ZSH_THEME="gnzh"
plugins=( git cp pip zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
alias i="sudo apt install"
alias r="sudo apt remove"
alias si="sudo snap install "
alias u="sudo apt dist-upgrade && sudo apt update"
alias fix="sudo apt-get autoremove && sudo dpkg --configure -a && sudo apt -f install && sudo apt-get --fix-broken inst"
alias ..="cd .."
alias ...="cd ../.."
alias c='clear'
alias r='env zsh -l'
alias cp="cpv --progress"
alias serveo="./home/mirage/serveo.sh"
alias ng80="killall ngrok && sed -i 's/8765/80/g' /home/mirage/.ngrok2/ngrok.yml && ngrok start --all"
alias ng8765="killall ngrok && sed -i 's/80/8765/g' /home/mirage/.ngrok2/ngrok.yml && ngrok start --all"
alias ngrc="sudo mcedit /home/mirage/.ngrok2/ngrok.yml"
alias m='mcedit'
alias local9091='killall ssh && ssh -R 80:localhost:9091 ssh.localhost.run'
alias local8765='killall ssh && ssh -R 80:localhost:8765 ssh.localhost.run'
alias local80='killall ssh && ssh -R 80:localhost:80 ssh.localhost.run'
alias net='sudo netstat -tlp | grep -E "4040|7999" && echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" && sudo netstat -nlpt | grep 127.0.0.1'
mkcd ()
{
  mkdir -p -- "$1" && cd -P -- "$1"
}
d="/home/mirage/downloads/"
usr='/usr'

#https://www.tecmint.com/share-files-over-a-local-network-in-linux/
