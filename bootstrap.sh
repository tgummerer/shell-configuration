#!/bin/bash

# Thanks to Steve Losh for the inspiration for this script. (https://bitbucket.org/sjl/shell-configuration/src)

mkdir -p $HOME/lib/oh-my-zsh
git clone git://github.com/tgummerer/oh-my-zsh $HOME/lib/oh-my-zsh

# clean up old files
rm $HOME/.zshrc
rm -r $HOME/.vim
rm -rf $HOME/.oh-my-zsh
rm $HOME/.vimrc
rm $HOME/.tmux.conf
rm $HOME/.bashrc
rm $HOME/.bash_profile
rm $HOME/.gitconfig
rm $HOME/.muttrc
rm -r $HOME/.mutt
ln -s $HOME/lib/shell-configuration/.gitconfig $HOME/.gitconfig
ln -s $HOME/lib/shell-configuration/.vim $HOME/.vim
ln -s $HOME/lib/shell-configuration/.vimrc $HOME/.vimrc
ln -s $HOME/lib/shell-configuration/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/lib/shell-configuration/.zshrc $HOME/.zshrc
ln -s $HOME/lib/shell-configuration/.muttrc $HOME/.muttrc
ln -s $HOME/lib/shell-configuration/.mutt $HOME/.mutt
ln -s $HOME/lib/shell-configuration/.config $HOME/.config
