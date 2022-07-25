#!/usr/bin/env bash

pwshProfileDirectory="$HOME/.config/powershell"
pwshProfile="$pwshProfileDirectory/Microsoft.PowerShell_profile.ps1"

if [[ ! -L "$pwshProfile" && ! -e "$pwshProfile" ]]; then
  mkdir "$pwshProfileDirectory" --parent
  ln -s "$(pwd -P)/pwsh/Microsoft.PowerShell_profile.ps1" "$pwshProfile"
fi
