if ! command -v zsh &> /dev/null
then
  if [ "$(uname -s)" == "Linux" ]
  then
    sudo apt install zsh
  fi
fi
