#!/usr/bin/env bash

# Thanks to Steve Losh for the inspiration for this script. (https://bitbucket.org/sjl/shell-configuration/src)

mkdir -p $HOME/lib/oh-my-zsh
git clone git://github.com/tgummerer/oh-my-zsh $HOME/lib/oh-my-zsh
mkdir -p ~/work
git clone git://github.com/git/git ~/work/git

# clean up old files
rm -f $HOME/.zshrc
rm -f -r $HOME/.vim
rm -f -r $HOME/.oh-my-zsh
rm -f $HOME/.vimrc
rm -f $HOME/.tmux.conf
rm -f $HOME/.bashrc
rm -f $HOME/.bash_profile
rm -f $HOME/.gitconfig
rm -f $HOME/.muttrc
rm -f -r $HOME/.mutt
ln -s $HOME/lib/shell-configuration/.gitconfig $HOME/.gitconfig
ln -s $HOME/lib/shell-configuration/.vim $HOME/.vim
ln -s $HOME/lib/shell-configuration/.vimrc $HOME/.vimrc
ln -s $HOME/lib/shell-configuration/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/lib/shell-configuration/.zshrc $HOME/.zshrc
ln -s $HOME/lib/shell-configuration/.muttrc $HOME/.muttrc
ln -s $HOME/lib/shell-configuration/.mutt $HOME/.mutt
ln -s $HOME/lib/shell-configuration/.config $HOME/.config
