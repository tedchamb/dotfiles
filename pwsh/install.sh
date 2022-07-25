#!/usr/bin/env bash

if [ ! -a "$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1" ]; then
  mkdir "$HOME/.config/powershell" --parent
  ln -s "$DOTFILES_ROOT/pwsh/Microsoft.PowerShell_profile.ps1" "$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1"
fi
