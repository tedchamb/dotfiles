#!/usr/bin/env bash

if ! command -v zsh &> /dev/null
then
  if [[ "$(uname -s)" == "Linux" ]]
  then
    sudo apt install zsh -y
  fi
fi

if [[ ! "$SHELL" == */zsh ]]
then
  sudo chsh -s "$(which zsh)" "$USER"
fi

if [ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
  REMOTE='https://github.com/ohmyzsh/ohmyzsh' sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ""  --unattended --keep-zshrc
fi

zhrcPath=~/.zshrc
if [[ ! -L "$zhrcPath" ]]; then
  if [[ ! -e "$zhrcPath" ]]; then
    ln -s "$DOTFILESPATH/zsh/zshrc.symlink" "$zhrcPath"
  else
    loadZhrcCommand="source '$DOTFILES/zsh/zshrc.symlink'"
    if ! grep "$loadZhrcCommand" < "$zhrcPath"
    then
      echo "$loadZhrcCommand" >> "$zhrcPath"
    fi
  fi
fi

if [[ "$(uname -s)" == "Linux" ]]
then
  # iTerm2 Shell Integration
  # https://iterm2.com/documentation-shell-integration.html
  curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
fi

# shellcheck source=./p10k/install.zsh
source ./p10k/install.zsh

# shellcheck source=./git/install.zsh
source ./git/install.zsh

# shellcheck source=./actionsbpdev/setup.zsh
source ./actionsbpdev/setup.zsh

# shellcheck source=./githubcodespace/setup.zsh
source ./githubcodespace/setup.zsh
