[![test-install](https://github.com/tedchamb/dotfiles/actions/workflows/test-install.yml/badge.svg)](https://github.com/tedchamb/dotfiles/actions/workflows/test-install.yml)

# dotfiles

Run `./install.sh` to install the dotfiles.

If PowerShell (`pwsh`) is not installed, the installer skips the PowerShell
profile and `logfmtpp` setup, whose release downloader requires PowerShell.
Other setup steps, including VS Code extensions, still run. Install PowerShell
and rerun `./install.sh` to enable the skipped steps.
