if ! command -v zsh &> /dev/null
then
  if [ "$(uname -s)" == "Linux" ]
  then
    sudo apt install zsh
  fi
fi

if [ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
  sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi