#!/usr/bin/env zsh

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  git clone --depth=1 git://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

if [ ! -a "$HOME/.p10k.zsh" ]; then
  mkdir "$HOME/.config/powershell" --parent
  ln -s "$DOTFILESPATH/p10k/p10k.zsh.symlink" "$HOME/.p10k.zsh"
fi
