#!/bin/bash

# detect root
cur_user="$USER"

if (( EUID == 0 ))
then
	echo "Don't run this installer as root!"
	exit 1
fi

echo "Installing the basics"

packages="mosh vim zsh sed git curl"
if command -v pacman &> /dev/null
then
	sudo pacman -Syu $packages --noconfirm
elif command -v apt &> /dev/null
then
	sudo apt install $packages -y
else
	echo "Package manager not supported!"
	echo "exiting..."
	exit 1
fi


echo "Pulling oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


echo "Cloning addons"
git clone https://github.com/zdharma/fast-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

sed -i 's/plugins=(git)/plugins=(\n\tgit\n\tfast-syntax-highlighting\n\tzsh-autosuggestions\n)/g' /home/$USER/.zshrc
source /home/$USER/.zshrc

# vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp ./vimrc /home/$USER/.vimrc

sudo mkdir /root/.vim
sudo ln -s /home/$cur_user/.vimrc /root/.vimrc
sudo ln -s /home/$cur_user/.vim/ /root/.vim/
