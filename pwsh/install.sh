#!/usr/bin/env bash

if [[ ! -e "$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1" ]]; then
  mkdir "$HOME/.config/powershell" --parent
  ln -s "$DOTFILESPATH/pwsh/Microsoft.PowerShell_profile.ps1" "$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1"
fi
