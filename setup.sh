#!/usr/bin/bash
ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
