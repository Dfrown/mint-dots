#!/bin/bash

dir=~/dotfiles
olddir=~/dotfiles_old
files="bashrc vimrc zshrc oh-my-zsh conkyrc"
echo "Creating $olddir for backup of existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

echo "Changing to $dir directory"
cd $dir
echo "...done"

for file in $files; do
	echo "Moving existing dotfiles to $olddir"
	mv ~/.$file ~/dotfiles_old
	echo "Creating symlink"
	ln -s $dir/$file ~/.$file
done