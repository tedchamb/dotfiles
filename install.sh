#!/usr/bin/env bash

set -x

cd "$(dirname "$0")" || exit
DOTFILESPATH=$(pwd -P)
export DOTFILESPATH

# create .profile if it doesn't exist
if [[ ! -a ~/.profile ]]; then
  echo '#!/usr/bin/env sh' > ~/.profile
fi

# add DOTFILESPATH to .profile
grep 'DOTFILESPATH=' < ~/.profile
if [[ $? == 1 ]]
then
  echo "export DOTFILESPATH=$DOTFILESPATH" >> ~/.profile
fi

if [[ "$(uname -s)" == "Linux" ]]
then
  sudo apt-get update

  if ! command -v curl &> /dev/null
  then
    sudo apt install curl -y
  fi
fi

# shellcheck source=./fonts/install.sh
source ./fonts/install.sh

# shellcheck source=./zsh/install.sh
source ./zsh/install.sh

# shellcheck source=./pwsh/install.sh
source ./pwsh/install.sh


