#!/bin/bash

# detect root
cur_user="$USER"

if (( EUID == 0 ))
then
	echo "Don't run this installer as root!"
	exit 1
fi

echo "Installing the basics"

packages="mosh vim zsh sed git curl wget"
if command -v pacman &> /dev/null
then
	sudo pacman -Syu $packages --noconfirm
elif command -v apt &> /dev/null
then
	sudo apt update
	sudo apt install $packages -y
	sudo wget -P /usr/local/share/fonts \
		https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf \
		https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf \
		https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf \
		https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
	fc-cache
else
	echo "Package manager not supported!"
	echo "exiting..."
	exit 1
fi


echo "Pulling oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


echo "Cloning addons"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

sed -i 's/plugins=(git)/plugins=(\n\tgit\n\tfast-syntax-highlighting\n\tzsh-autosuggestions\n)/g' $HOME/.zshrc
sed -e '/ZSH_THEME="robbyrussell"/ s/^#*/# /' -i $HOME/.zshrc
sed -e '/ZSH_THEME="robbyrussell"/ a ZSH_THEME="powerlevel10k/powerlevel10k"' -i $HOME/.zshrc
source /home/$USER/.zshrc


if command -v apt &> /dev/null
then
	sudo apt update
	sudo apt install $packages -y
fi



# vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp ./vimrc $HOME/.vimrc

sudo mkdir /root/.vim
sudo ln -s /home/$cur_user/.vimrc /root/.vimrc
sudo ln -s /home/$cur_user/.vim/ /root/.vim/
