if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


export ZSH="$HOME/.oh-my-zsh"
export DISPLAY=:0.0
ZSH_THEME="powerlevel10k/powerlevel10k"
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
plugins=( git cp pip sudo zsh-syntax-highlighting zsh-autosuggestions tmux systemd wp-cli python pylint pip npm github cp adb )
source $ZSH/oh-my-zsh.sh
alias i="sudo apt install"
alias u="sudo apt-get autoremove && sudo dpkg --configure -a && sudo apt -f install && sudo apt-get --fix-broken install && sudo apt dist-upgrade && sudo apt update && sudo pip install --upgrade pip"
alias ..="cd .."
alias ...="cd ../.."
alias pi="sudo arp-scan --interface=wlp2s0 --localnet | grep Raspberry"
alias c="clear"
alias r="env zsh -l"
alias npm="sudo npm"
alias cp="cpv --progress"
alias disk="sudo fdisk -l | grep "/dev/sd""
alias Webphp="php -S localhost:5000"
alias serveo="~/.config/serveo.sh"
alias mc="sudo mc"
alias m="sudo mcedit"
alias airplay="~/RPiPlay/build/rpiplay"
alias raspi="~/.config/monitor.sh -a"
alias port="sudo netstat -plnt | grep 0:"
alias scanW="sudo iwlist wlan0 scan | grep ESSID"
alias p="python3"
alias ls="ls -A --color=auto"
alias cfg="cd ~/.config"
alias ldm="sudo systemctl start lightdm.service"
alias key="python3 ~/gpio/key.py"

kp () { sudo pkill -9 -f "$1" }
pp () { ps -ef | grep "$1" }
mkcd () { mkdir -p -- "$1" && cd -P -- "$1" }
lt () { lt --port "$1" }
mnt () { mkdir -p /mnt/"$1" && sudo mount /dev/"$1" /mnt/"$1" }
rmnt () { unmount /mnt/"$1" }
web () { ssh -R 80:localhost:"$1" ssh.localhost.run }
ytb-mpv () { youtube-dl -o - "$1" | mpv -}
net () { sudo netstat -tlp | grep -E ""$1"" }
vnc () { sudo systemctl "$1" vncserver-x11-serviced.service }
relay24 () { case "$1" in
          start)
            python3 /home/pi/gpio/relay24.py start
          ;;
          stop)
            python3 /home/pi/gpio/relay24.py stop
            ;;
          *)
            echo "Usage: {start|stop}"
            exit 1
            ;;
        esac
        
         }

clear
#https://www.tecmint.com/share-files-over-a-local-network-in-linux/
