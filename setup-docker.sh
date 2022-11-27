#!/bin/bash

heading() {
clear
cat ascii.txt
echo -e "\n\n"
}

error() {
echo "Try again?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) main; break;;
        No ) exit;;
    esac
done
    main
}

main() {
heading

echo -n 'Username: '
read -r USERNAME
echo
echo -n 'Password: '
read -sr PASSWD


docker build -t dev-env . 
CONTAINER_ID=$(docker run --cap-add=SYS_RAWIO --cap-add=NET_BIND_SERVICE --privileged -d dev-env)
echo "$CONTAINER_ID"
docker exec -it "$CONTAINER_ID" useradd -m "$USERNAME"
docker exec -it "$CONTAINER_ID" usermod -aG sudo "$USERNAME"
docker exec -it -e USERNAME="$USERNAME" -e PASSWD="$PASSWD" "$CONTAINER_ID" bash -c 'echo $USERNAME:$PASSWD | chpasswd'

# # VIM
# docker exec -it "$CONTAINER_ID" bash -c 'mkdir /root/.vim'
# docker exec -it -u "$USERNAME" "$CONTAINER_ID" bash -c 'cp /tmp/vimrc "$HOME"/.vimrc'
# docker exec -it -u "$USERNAME" "$CONTAINER_ID" bash -c 'ln -s "$HOME"/.vimrc /root/.vimrc'

# SETUP SHELL
docker exec -it -u "$USERNAME" --privileged "$CONTAINER_ID" zsh -c 'cd /tmp && /tmp/install.sh'
docker exec -it -u "$USERNAME" -e USERNAME="$USERNAME" "$CONTAINER_ID" zsh -c 'echo cd /home/$USERNAME >> /home/$USERNAME/.zshrc'
# START SHELL
docker exec -it -u "$USERNAME" --privileged "$CONTAINER_ID" zsh
}

# Program Entrypoint
main