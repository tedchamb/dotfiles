#!/usr/bin/env zsh

git --version

if [[ ! -a ~/.gitconfig ]]
then
    ln -s "$DOTFILESPATH/git/gitconfig.symlink" "$HOME/.gitconfig"
fi

if [[ ! -a ~/.gitconfig.local ]]
then
    ln -s "$DOTFILESPATH/git/gitconfig.local.symlink" "$HOME/.gitconfig.local"
fi

if [[ ! -a ~/.gitignore ]]
then
    ln -s "$DOTFILESPATH/git/gitignore.symlink" "$HOME/.gitignore"
fi
