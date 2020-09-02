# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls='gls -F --color'
  alias l='gls -lAh --color'
  alias ll='gls -l --color'
  alias la='gls -A --color'
else
  alias ls='ls --color=auto'
  alias l='ls --color=auto -lAh'
  alias ll='ls --color=auto -l'
  alias la='ls --color=auto -A'
fi
