#!/usr/bin/env zsh

git --version

if [[ ! -a ~/.gitconfig ]]
then
    zsh -c "$DOTFILESPATH/git/gitconfig.symlink"
fi

if [[ ! -a ~/.gitconfig.local ]]
then
    zsh -c "$DOTFILESPATH/git/gitconfig.local.symlink"
fi

if [[ ! -a ~/.gitignore ]]
then
    zsh -c "$DOTFILESPATH/git/gitignore.symlink"
fi
