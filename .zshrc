# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/data/data/com.termux/files/usr/bin/env zsh
# =============================================================================
# ZSH Configuration File (.zshrc)
# Based on:- https://github.com/zdharma-continuum/zinit-configs/tree/master/vladdoster
# =============================================================================

# Enable auto-cd
setopt AUTO_CD
# Turn off "no match" errors
setopt nonomatch

# -------------------------------------------
# Edit Command Buffer
# -------------------------------------------
# Open the current command in your $EDITOR (e.g., neovim)
# Press Ctrl+X followed by Ctrl+E to trigger
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# -------------------------------------------
# Undo in ZSH
# -------------------------------------------
# Press Ctrl+z to undo
bindkey '^Z' undo
# Redo widget exists but has no default binding:
bindkey '^Y' redo

# -------------------------------------------
# Magic Space - Expand History
# -------------------------------------------
# Expands history expressions like !! or !$ when you press space
bindkey ' ' magic-space

# -------------------------------------------
# zmv - Advanced Batch Rename/Move
# -------------------------------------------
# Enable zmv
autoload -Uz zmv

# Usage examples:
# zmv '(*).log' '$1.txt'           # Rename .log to .txt
# zmv -w '*.log' '*.txt'           # Same thing, simpler syntax
# zmv -n '(*).log' '$1.txt'        # Dry run (preview changes)
# zmv -i '(*).log' '$1.txt'        # Interactive mode (confirm each)

# -------------------------------------------
# Custom Widgets
# -------------------------------------------

# # Copy current command buffer to clipboard
# function copy-buffer-to-clipboard() {
#   echo -n "$BUFFER" | xclip
#   zle -M "Copied to clipboard"
# }
#
# zle -N copy-buffer-to-clipboard
# bindkey '^X^C' copy-buffer-to-clipboard

# -----------------------------------------------------------------------------
# ZINIT PLUGIN MANAGER INSTALLATION
# -----------------------------------------------------------------------------
# Auto-install Zinit if not present
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    # Only show output if not using instant prompt
    if [[ -z "$P9K_INSTANT_PROMPT" ]]; then
        print -P "%F{33}Installing %F{220}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager...%f"

        # Create directory structure
        if command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"; then
            # Try to clone the repository
            if command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"; then
                print -P "%F{33}Installation successful.%f"
            else
                print -P "%F{160}Git clone failed. Please check your internet connection and try again.%f"
                return 1
            fi
        else
            print -P "%F{160}Failed to create zinit directory.%f"
            return 1
        fi
    else
        # Silent installation during instant prompt
        command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
        command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" >/dev/null 2>&1
    fi
fi

# Load Zinit
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# -----------------------------------------------------------------------------
# ZINIT CONFIGURATION
# -----------------------------------------------------------------------------
# Zinit directory structure - UPDATED TO MATCH DEFAULT PATH
typeset -gAH ZINIT
ZINIT[HOME_DIR]="$HOME/.local/share/zinit"
ZINIT[BIN_DIR]="$ZINIT[HOME_DIR]/zinit.git"
ZINIT[COMPLETIONS_DIR]="$ZINIT[HOME_DIR]/completions"
ZINIT[SNIPPETS_DIR]="$ZINIT[HOME_DIR]/snippets"
ZINIT[ZCOMPDUMP_PATH]="$ZINIT[HOME_DIR]/zcompdump"
ZINIT[PLUGINS_DIR]="$ZINIT[HOME_DIR]/plugins"
ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=1

# Zinit variables
ZI_REPO='zdharma-continuum'

# -----------------------------------------------------------------------------
# OH-MY-ZSH & PREZTO PLUGINS
# -----------------------------------------------------------------------------
# Load useful Oh My Zsh library functions and plugins
zi for is-snippet \
    OMZL::{compfix,completion,git,key-bindings}.zsh \
    PZT::modules/{history}

# Load completions for specific tools
zi as'completion' for \
    OMZP::{pip/_pip,terraform/_terraform}

# -----------------------------------------------------------------------------
# ZINIT ANNEXES
# -----------------------------------------------------------------------------
# Load useful Zinit extensions
zi light-mode for \
    "$ZI_REPO"/zinit-annex-{binary-symlink,patch-dl,submods}

# -----------------------------------------------------------------------------
# PYTHON CONFIGURATION
# -----------------------------------------------------------------------------
# Custom pip completion function
function _pip_completion() {
    local words cword
    read -Ac words
    read -cn cword
    reply=(
        $(
            COMP_WORDS="$words[*]"
            COMP_CWORD=$(( cword-1 ))
            PIP_AUTO_COMPLETE=1 $words 2>/dev/null
        )
    )
}
compctl -K _pip_completion pip3

# -----------------------------------------------------------------------------
# ZSH ENHANCEMENT PLUGINS
# -----------------------------------------------------------------------------

# Enhanced completions - Additional completion definitions
zi ice zsh-users/zsh-completions

# Auto-suggestions - Suggests commands as you type based on history
zi ice atload'_zsh_autosuggest_start' \
    atinit'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
bindkey "^_" autosuggest-execute
bindkey "^ " autosuggest-accept'
zi light zsh-users/zsh-autosuggestions

# Fast syntax highlighting - Real-time command syntax validation
zi light-mode for \
    $ZI_REPO/fast-syntax-highlighting


# FZF history search - Fuzzy search through command history
zi ice joshskidmore/zsh-fzf-history-search

# Zsh autocomplete - Real-time type-ahead autocompletion
zi ice atload'
bindkey              "^I" menu-select
bindkey -M menuselect "$terminfo[kcbt]" reverse-menu-complete'
zi light marlonrichert/zsh-autocomplete

# -----------------------------------------------------------------------------
# FINALIZATION
# -----------------------------------------------------------------------------
# Initialize completions and replay cached completions
# at the end of a Zinit configuration to ensure that after all plugins are loaded,
# the completion system is properly initialized and
# syntax highlighting/autosuggestion widgets are correctly bound
#
# Uncomment it if you have issue with highlighting/autosuggestion
#
# zi for atload'
#       zicompinit; zicdreplay
#       _zsh_highlight_bind_widgets
#       _zsh_autosuggest_bind_widgets' \
    #     as'null' id-as'zinit/cleanup' lucid nocd wait \
    #   $ZI_REPO/null
#

unset ZI_REPO ZI_REPO
# Load theme
#source "/data/data/com.termux/files/home/.zsh-themes/td.zsh-theme"
[[ -f /data/data/com.termux/files/home/.shell_rc_content ]] && source /data/data/com.termux/files/home/.shell_rc_content
[[ -f /data/data/com.termux/files/home/.aliases ]] && source /data/data/com.termux/files/home/.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zinit light romkatv/powerlevel10k

alias i="sudo apt install"
alias u="sudo apt-get autoremove && sudo dpkg --configure -a && sudo apt -f install && sudo apt-get --fix-broken install && sudo apt dist-upgrade && sudo apt update && sudo pip install --upgrade pip"
alias ..="cd .."
alias ...="cd ../.."
alias pi="sudo arp-scan --interface=wlp2s0 --localnet | grep Raspberry"
alias c="clear"
alias dd="dcfldd"
alias code="sudo code --user-data-dir Documents/"
alias a="sudo arduino"
alias r="env zsh -l"
alias termshark="sudo termshark"
alias cp="gcp"
alias disk="sudo fdisk -l | grep "/dev/sd""
alias mc="sudo mc"
alias n="micro"
alias top="bashtop"
alias port="netstat -at"
alias scanW="sudo iwlist wlp2s0 scan | grep ESSID"
alias p="python3"
alias z="zellij"
alias ls="eza  -a --icons"
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
t () { if [[ -z $1 ]]
        then
            exa -T -a --icons
            exit 1
        else
            exa -T -a --level=$1 --icons
            exit 1
        fi
        }
clear
