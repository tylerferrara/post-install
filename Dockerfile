FROM debian:bullseye
RUN apt update; apt install sudo wget curl net-tools iproute2 unzip pciutils mosh vim zsh sed git -y
# RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# RUN cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
# RUN git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$HOME"/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
# RUN git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME"/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# RUN sed -i 's/plugins=(git)/plugins=(\n\tgit\n\tfast-syntax-highlighting\n\tzsh-autosuggestions\n)/g' "$HOME"/.zshrc
# RUN sed -e '/ZSH_THEME="robbyrussell"/ s/^#*/# /' -i "$HOME"/.zshrc
# RUN sed -e '/ZSH_THEME="robbyrussell"/ a ZSH_THEME="powerlevel10k/powerlevel10k"' -i "$HOME"/.zshrc
# RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

COPY . /tmp
ENTRYPOINT [ "sleep", "infinity" ]