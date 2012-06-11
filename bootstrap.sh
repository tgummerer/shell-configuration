#!/bin/bash

# Thanks to Steve Losh for the inspiration for this script. (https://bitbucket.org/sjl/shell-configuration/src)

mkdir -p ~/lib/oh-my-zsh
git clone git://github.com/tgummerer/oh-my-zsh ~/lib/oh-my-zsh

# clean up old files
rm ~/.zshrc
rm -r ~/.vim
rm -rf ~/.oh-my-zsh
rm ~/.vimrc
rm ~/.tmux.conf
rm ~/.bashrc
rm ~/.bash_profile
rm ~/.gitconfig
rm ~/.muttrc
rm -r ~/.mutt
ln -s ~/lib/shell-configuration/.gitconfig ~/.gitconfig
ln -s ~/lib/shell-configuration/.vim ~/.vim
ln -s ~/lib/shell-configuration/.vimrc ~/.vimrc
ln -s ~/lib/shell-configuration/.tmux.conf ~/.tmux.conf
ln -s ~/lib/shell-configuration/.zshrc ~/.zshrc
ln -s ~/lib/shell-configuration/.muttrc ~/.muttrc
ln -s ~/lib/shell-configuration/.mutt ~/.mutt
ln -s ~/lib/shell-configuration/.config ~/.config
