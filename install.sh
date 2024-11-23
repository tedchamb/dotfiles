#!/usr/bin/env bash

set -xe

cd "$(dirname "$0")" || exit
DOTFILESPATH=$(pwd -P)
export DOTFILESPATH

profilePath=~/.profile

# create .profile if it doesn't exist
if [[ ! -e "$profilePath" ]]; then
  echo '#!/usr/bin/env sh' > "$profilePath"
fi

# add DOTFILESPATH to .profile
dotFilesPathCommand="export DOTFILESPATH=$DOTFILESPATH"
if ! grep "$dotFilesPathCommand" < "$profilePath"
then
  echo "$dotFilesPathCommand" >> "$profilePath"
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
source "$DOTFILESPATH/fonts/install.sh"

# shellcheck source=./zsh/install.sh
source "$DOTFILESPATH/zsh/install.sh"

# shellcheck source=./pwsh/install.sh
source "$DOTFILESPATH/pwsh/install.sh"

# shellcheck source=./logfmtpp/install.sh
"$DOTFILESPATH/logfmtpp/install.sh"
