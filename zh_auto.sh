#!/bin/bash

if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null; then
	echo -e "ZSH and Git are already installed\n"
else
	if sudo apt install -y zsh git wget ; then echo -e "ZSH and Git Installed\n"
	else echo -e "Can't install ZSH or Git\n" && exit
	fi
fi


if mv -n ~/.zshrc ~/.zshrc-backup; then	# if already have zshrc-backup, keep it, don't overwrite
	echo -e "Backed up the current .zshrc to .zshrc-backup\n"
fi


git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/plugins/zsh-history-substring-search
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/themes/powerlevel10k




chsh -s $(which zsh)
env zsh -l
exit
