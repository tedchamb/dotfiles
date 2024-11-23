#!/usr/bin/env bash

set -e

scriptDir=$(dirname "$0")

rm -dr "$scriptDir/bin"

$scriptDir/../github/download-release.ps1 -Repo tedchamb/logfmtpp -Name logfmtpp -Destination "$scriptDir/bin"

chmod +x "$scriptDir/bin/logfmtpp"

tool="$scriptDir/bin/logfmtpp"
symlinkPath="/usr/local/bin/$(basename "$tool")"

if [[ ! -L "$symlinkPath" ]]; then
    echo "Adding symlink to $tool at $symlinkPath"
    sudo ln -s "$(realpath "$tool")" "$symlinkPath"
else
    echo "Path for symlink already exists: $symlinkPath"
fi
