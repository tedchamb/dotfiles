#!/usr/bin/env bash

if ! command -v zsh &> /dev/null
then
  if [[ "$(uname -s)" == "Linux" ]]
  then
    sudo apt install zsh -y
  fi
fi

if [[ ! "$SHELL" == */zsh ]] && [[ -n $USER ]];
then
  sudo chsh -s "$(which zsh)" "$USER"
fi

if [ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
  REMOTE='https://github.com/ohmyzsh/ohmyzsh' sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ""  --unattended --keep-zshrc
fi

zshrcSymlinkPath=$(pwd -P)/zsh/zshrc.symlink
zshrcPath=~/.zshrc
if [[ ! -L "$zshrcPath" ]]; then
  if [[ ! -e "$zshrcPath" ]]; then
    ln -s "$zshrcSymlinkPath" "$zshrcPath"
  else
    loadZhrcCommand="source '$zshrcSymlinkPath'"
    if ! grep "$loadZhrcCommand" < "$zshrcPath"
    then
      echo "$loadZhrcCommand" >> "$zshrcPath"
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

# shellcheck source=./githubcodespace/setup.zsh
source ./githubcodespace/setup.zsh

azureSubIdCommand="export AzureSubscriptionId='16eb6e57-e88b-49c9-8acb-26048bee1f93'"
if ! (grep -F "$azureSubIdCommand" ~/.profile); then
  echo "$azureSubIdCommand" >> ~/.profile
fi

command="export GOPROXY=https://goproxy.githubapp.com/mod,https://proxy.golang.org/,direct"
if ! (grep -F "$command" ~/.profile); then
  echo "$command" >> ~/.profile
fi

command="export GOPRIVATE="
if ! (grep -F "$command" ~/.profile); then
  echo "$command" >> ~/.profile
fi

command="export GONOPROXY="
if ! (grep -F "$command" ~/.profile); then
  echo "$command" >> ~/.profile
fi

command="export GONOSUMDB=github.com/github/*"
if ! (grep -F "$command" ~/.profile); then
  echo "$command" >> ~/.profile
fi
