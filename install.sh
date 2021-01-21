#!/bin/bash
echo "Installing the basics"
$(sudo pacman -Sy vim zsh sed git curl --noconfirm)

echo "Pulling oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Cloning addons"
git clone https://github.com/zdharma/fast-syntax-highlighting.git /home/$USER/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/$USER/.oh-my-zsh/custom/plugins/zsh-autosuggestions

sed -i 's/plugins=(git)/plugins=(\n\tgit\n\tfast-syntax-highlighting\n\tzsh-autosuggestions\n)/g' /home/$USER/.zshrc
source /home/$USER/.zshrc

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim




# mkdir /home/$USER/.vim
# mkdir /home/$USER/.vim/colors
# cp ./sonokai.vim /home/$USER/.vim/colors/sonokai.vim

cp ./vimrc /home/$USER/.vimrc
