if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


export ZSH="$HOME/.oh-my-zsh"
export DISPLAY=:0.0
ZSH_THEME="powerlevel10k/powerlevel10k"
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
plugins=( git cp pip sudo zsh-syntax-highlighting zsh-autosuggestions tmux systemd wp-cli python pylint pip npm cp adb )
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
alias airplay="~/RPiPlay/build/rpiplay"
alias raspi="~/.config/monitor.sh -a"
alias port="sudo netstat -plnt | grep 0:"
alias scanW="sudo iwlist wlan0 scan | grep ESSID"
alias p="python3"
alias ls="ls -A --color=auto"
alias cfg="cd ~/.config"
alias start="sudo crontab -u pi -e"
alias ldm="sudo systemctl start lightdm.service"
alias rmdir="rmdir --ignore-fail-on-non-empty"
alias raspi="ssh pi@raspi.local 'sudo apt-get autoremove && sudo dpkg --configure -a && sudo apt -f install && sudo apt-get --fix-broken install && sudo apt dist-upgrade && sudo apt update && sudo pip install --upgrade pip'"

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
          start | on)
            python3 /home/pi/gpio/relay24.py start
          ;;
          stop | off)
            python3 /home/pi/gpio/relay24.py stop
            ;;
          *)
            echo "Usage: {start|stop}"
            exit 1
            ;;
        esac
        
         }

key () { case "$1" in
          start | on)
            sed -i '74 s/#tmux/tmux/'  ~/.oh-my-zsh/plugins/tmux/tmux.plugin.zsh
          ;;
          stop | off)
            sed -i '74 s/tmux/#tmux/'  ~/.oh-my-zsh/plugins/tmux/tmux.plugin.zsh
            ;;
          *)
            echo "Usage: {start|stop}"
            exit 1
            ;;
        esac
        
         }
         
function cpv()
{
  local DST=${@: -1}                    # last element
  local SRC=( ${@: 1 : $# - 1} )        # array with rest of elements

  # checks
  type pv &>/dev/null || { echo "install pv first"; return 1; }
  [ $# -lt 2  ]       && { echo "too few args"    ; return 1; }

  # special invocation
  function cpv_rename()
  {
    local SRC="$1"
    local DST="$2"
    local DSTDIR="$( dirname "$DST" )"

    # checks
    if   [ $# -ne 2     ]; then echo "too few args"          ; return 1; fi
    if ! [ -e "$SRC"    ]; then echo "$SRC doesn't exist"    ; return 1; fi
    if   [ -d "$SRC"    ]; then echo "$SRC is a dir"         ; return 1; fi
    if ! [ -d "$DSTDIR" ]; then echo "$DSTDIR does not exist"; return 1; fi

    # actual copy
    echo -e "\n$SRC 🡺  $DST"
    pv   "$SRC" >"$DST"
  }

  # special case for cpv_rename()
  if ! [ -d "$DST" ]; then cpv_rename "$@"; return $?; fi;

  # more checks
  for src in "${SRC[@]}"; do 
    local dst="$DST/$( basename "$src" )"
    if ! [ -e "$src" ]; then echo "$src doesn't exist" ; return 1;
    elif [ -e "$dst" ]; then echo "$dst already exists"; return 1; fi
  done

  # actual copy
  for src in "${SRC[@]}"; do 
    if ! [ -d "$src" ]; then 
      local dst="$DST/$( basename "$src" )"
      echo -e "\n$src 🡺  $dst"
      pv "$src" > "$dst"
    else 
      local dir="$DST/$( basename "$src" )"
      mkdir "$dir" || continue
      local srcs=( $src/* )
      cpv "${srcs[@]}" "$dir";
    fi
  done
  unset cpv_rename
}

clear

#https://www.tecmint.com/share-files-over-a-local-network-in-linux/
#[[ -f /etc/resolv.conf && -f /etc/hosts ]] && echo "Both files exist.
#[ -f /etc/resolv.conf ] && { echo "$FILE exist"; echo "sdsadasdist"; } || echo "$FILE does not exist"
# sed -i -e 's/Ubuntu/Kubuntu/; s/Centos/Fedora/' texte.txt






