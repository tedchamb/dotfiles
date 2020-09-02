if ! command -v zsh &> /dev/null
then
  if [ "$(uname -s)" == "Linux" ]
  then
    sudo apt install zsh
  fi
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi