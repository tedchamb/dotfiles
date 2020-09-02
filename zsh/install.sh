if ! command -v zsh &> /dev/null
then
  if [ "$(uname -s)" == "Linux" ]
  then
    sudo apt install zsh -y
  fi
fi

sudo chsh -s $(which zsh) $USER

if [ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ""  --unattended --keep-zshrc
fi