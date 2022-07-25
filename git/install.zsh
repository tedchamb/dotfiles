#!/usr/bin/env zsh

git --version

if [[ ! -e ~/.gitconfig ]]
then
    ln -s "$DOTFILESPATH/git/gitconfig.symlink" "$HOME/.gitconfig"
fi

if [[ ! -e ~/.gitconfig.local ]]
then
    ln -s "$DOTFILESPATH/git/gitconfig.local.symlink" "$HOME/.gitconfig.local"
fi

if [[ ! -e ~/.gitignore ]]
then
    ln -s "$DOTFILESPATH/git/gitignore.symlink" "$HOME/.gitignore"
fi
