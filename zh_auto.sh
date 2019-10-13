#!/bin/bash

if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null; then
	echo -e "ZSH and Git are already installed\n"
else
	if sudo apt install -y zsh git wget || sudo dnf install -y zsh git wget || sudo yum install -y zsh git wget || sudo brew install git zsh wget ; then
		echo -e "ZSH and Git Installed\n"
	else
		echo -e "Can't install ZSH or Git\n" && exit
	fi
fi


if mv -n ~/.zshrc ~/.zshrc-backup; then	# if already have zshrc-backup, keep it, don't overwrite
	echo -e "Backed up the current .zshrc to .zshrc-backup\n"
fi


git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh



mkdir ~/.quickzsh		# external plugins, things, will be instlled in here

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/plugins/zsh-history-substring-search
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/themes/powerlevel10k

# INSTALL FONTS

if git clone --depth=1 https://github.com/powerline/fonts.git --depth=1 ~/.quickzsh/powerline_fonts; then :
else
	cd ~/.quickzsh/powerline_fonts && git pull
fi

if ~/.quickzsh/powerline_fonts/install.sh && rm -rf ~/.quickzsh/powerline_fonts; then
	echo -e "\npowerline_fonts Installed\n"
else
	echo -e "\npowerline_fonts Installation Failed\n"
fi


wget -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
wget -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts/

fc-cache -fv ~/.fonts


if git clone --depth 1 https://github.com/junegunn/fzf.git ~/.quickzsh/fzf; then :
else
	cd ~/.quickzsh/fzf && git pull
fi
~/.quickzsh/fzf/install --all --key-bindings --completion --no-update-rc --64

if git clone --depth 1 https://github.com/supercrabtree/k $HOME/.oh-my-zsh/custom/plugins/k; then :
else
	cd ~/.oh-my-zsh/custom/plugins/k && git pull
fi

if git clone --depth 1 https://github.com/pindexis/marker ~/.quickzsh/marker; then :
else
	cd ~/.quickzsh/marker && git pull
fi

if ~/.quickzsh/marker/install.py; then
	echo -e "Installed Marker\n"
else
	echo -e "Marker Installation Had Issues\n"
fi

if [[ $1 == "--cp-hist" ]]; then
    echo -e "\nCopying bash_history to zsh_history\n"
    if command -v python &>/dev/null; then
        wget https://gist.githubusercontent.com/muendelezaji/c14722ab66b505a49861b8a74e52b274/raw/49f0fb7f661bdf794742257f58950d209dd6cb62/bash-to-zsh-hist.py
        cat ~/.bash_history | python bash-to-zsh-hist.py >> ~/.zsh_history
    else
		if command -v python3 &>/dev/null; then
			wget https://gist.githubusercontent.com/muendelezaji/c14722ab66b505a49861b8a74e52b274/raw/49f0fb7f661bdf794742257f58950d209dd6cb62/bash-to-zsh-hist.py
			cat ~/.bash_history | python3 bash-to-zsh-hist.py >> ~/.zsh_history
		else
    		echo "Python is not installed, can't copy bash_history to zsh_history\n"
		fi
    fi
else
    echo -e "\nNot copying bash_history to zsh_history, as --cp-hist is not supplied\n"
fi


chsh -s $(which zsh)
env zsh -l
exit
