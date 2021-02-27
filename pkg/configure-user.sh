#!/bin/bash

if [ "$EUID" -eq 0 ]
    then echo "do not run as root"
        exit
fi

# ln -sf ${HOME}/.config/nvim/init ${HOME}/.vimrc

# echo "installing vim-plug"
# echo
# if [ ! -e ~/.local/share/nvim/site/autoload/plug.vim ]; then
#   curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
# 	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# fi

mkdir -p \
  ${HOME}/s \
  ${HOME}/.icons \
  ${HOME}/.local \
  ${HOME}/.ssh \
  ${HOME}/.config/conky

cp -fvr \
  ../dotfiles/.bash_aliases \
  ../dotfiles/.bash_profile \
  ../dotfiles/.bashrc \
  ../dotfiles/.gitconfig \
  ../dotfiles/.xinitrc \
  ../dotfiles/.Xresources \
  ../dotfiles/.xbindkeysrc \
  ${HOME}/

# cp -vr ../dotfiles/.ssh/config ${HOME}/.ssh/
# cp -vr ../dotfiles/.config/picom/picom.conf ${HOME}/.config/picom/
# cp -vr ../dotfiles/.config/nvim/init.vim ${HOME}/.config/nvim/
# cp -vr ../dotfiles/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml ${HOME}/.config/xfce4/xfconf/xfce-perchannel-xml/
cp -vr ../s/* ${HOME}/s/
cp -vr ../dotfiles/.icons/* ${HOME}/.icons/
cp -vr ../dotfiles/.local/* ${HOME}/.local/
cp -vr ../dotfiles/.config/conky/conky.conf ${HOME}/.config/conky/

# update xfce settings
killall xfconfd
/usr/lib/xfce4/xfconf/xfconfd &
xfsettingsd --replace &

# Install yay
cd /opt
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R stutz:users ./yay
cd yay
makepkg -si
