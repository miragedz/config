if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export DISPLAY=:0.0
ZSH_THEME="powerlevel10k/powerlevel10k"
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
plugins=( 
  zsh-syntax-highlighting zsh-autosuggestions systemd wp-cli python pylint npm github adb  pip git cp pip sudo 
  )
source $ZSH/oh-my-zsh.sh
alias i="sudo apt install"
alias u="sudo apt-get autoremove && sudo dpkg --configure -a && sudo apt -f install && sudo apt-get --fix-broken install && sudo apt dist-upgrade && sudo apt update && sudo pip install --upgrade pip"
alias ..="cd .."
alias ...="cd ../.."
alias pi="sudo arp-scan --interface=wlp2s0 --localnet | grep Raspberry"
alias c="clear"
alias code="sudo code --user-data-dir Documents/"
alias a="sudo arduino"
alias r="env zsh -l"
alias gdm="sudo systemctl restart gdm"
alias cp="cpv --progress"
alias disk="sudo fdisk -l | grep "/dev/sd""
alias Webphp="php -S localhost:8000"
alias mc="sudo mc"
alias m="sudo mcedit"
alias n="nano -m"
alias airplay="~/RPiPlay/build/rpiplay"
alias port="netstat -at"
alias scanW="sudo iwlist wlp2s0 scan | grep ESSID"
alias p="python3"
alias ls="exa -l -a --icons"
alias cfg="cd ~/.config"
alias ldm="sudo systemctl start lightdm.service vncserver-x11-serviced.service"
alias rmdir="sudo rmdir --ignore-fail-on-non-empty"
alias dns="curl https://www.duckdns.org/update\?domains\=miragedz\&token\=18c=z0e58f-5605-4475-a180-965097e89e42\&ip\=  && https://freemyip.com/update?token=74e00f38579c59339956585c&domain=miragedz.freemyip.com &&curl icanhazip.com "
alias sublime="sudo /snap/sublime-text/current/opt/sublime_text/sublime_text"

kp () { sudo pkill -9 -f "$1" }
pp () { ps -ef | grep "$1" }
mkcd () { mkdir -p -- "$1" && cd -P -- "$1" }
lt () { lt --port "$1" }
mnt () { mkdir -p /mnt/"$1" && sudo mount /dev/"$1" /mnt/"$1" }
rmnt () { unmount /mnt/"$1" }
web () { ssh -R 80:localhost:"$1" ssh.localhost.run }
ytb-mpv () { youtube-dl -o - "$1" | mpv -}
net () { sudo netstat -tlp | grep -E ""$1"" }
cctv () { sudo systemctl "$1" motion.service motioneye.service }
samba () { sudo systemctl "$1" smbd.service }
key () { case "$1" in
          stop | off) sed -i '10d' ~/.zshrc ;;
          start | on) sed -i '10 i tmux' ~/.zshrc ;;
          *)
            echo "Usage: {start|stop}"
            exit 1
            ;;
        esac
        }
t () { if [[ -z $1 ]]
        then
            exa -T --icons
            exit 1
        else
            exa -T --level=$1 --icons
            exit 1          
        fi
        }
clear

#[[ -f /etc/resolv.conf && -f /etc/hosts ]] && echo "Both files exist.
#[ -f /etc/resolv.conf ] && { echo "$FILE exist"; echo "sdsadasdist"; } || echo "$FILE does not exist"
#http://tiswww.case.edu/php/chet/bash/bash.html#lbBW
#https://misc.flogisoft.com/bash/tip_colors_and_formatting         color bash
# sed -i '85 s/tmux/#tmux/g' file.txt
# sed -i 's/tmux//1' .zshrc # delete the firste string
# sed -e -i '/abc/ s/abc/100/' # remplace "abc" if exixte
# sed '3,6d' filename.txt #To Delete line from range
# sed -i '12,$d' filename.txt # Delete from 12th line to last line
# sed -i '/abc/d' filename.txt # Delete pattern matching line
# sed -i -e '3 s/^#//' filename.txt #remove ine 3th line le #caracter
# sed -r 's/.{28}//' file.sh   del first 28th caracter

#-n VAR - True if the length of VAR is greater than zero.
#-z VAR - True if the VAR is empty.
#STRING1 = STRING2 - True if STRING1 and STRING2 are equal.
#STRING1 != STRING2 - True if STRING1 and STRING2 are not equal.
#INTEGER1 -eq INTEGER2 - True if INTEGER1 and INTEGER2 are equal.
#INTEGER1 -gt INTEGER2 - True if INTEGER1 is greater than INTEGER2.
#INTEGER1 -lt INTEGER2 - True if INTEGER1 is less than INTEGER2.
#INTEGER1 -ge INTEGER2 - True if INTEGER1 is equal or greater than INTEGER2.
#INTEGER1 -le INTEGER2 - True if INTEGER1 is equal or less than INTEGER2.
#-h FILE - True if the FILE exists and is a symbolic l745680ink.
#-r FILE - True if the FILE exists and is readable.
#-w FILE - True if the FILE exists and is writable.
#-x FILE - True if the FILE exists and is executable.
#-d FILE - True if the FILE exists and is a directory.
#-e FILE - True if the FILE exists and is a file, regardless of type (node, directory, socket, etc.).
#-f FILE - True if the FILE exists and is a regular file (not a directory or device).
