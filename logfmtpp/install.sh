#!/usr/bin/env bash

set -e

scriptDir=$(dirname "$0")

binDir="$scriptDir/bin"
if [[ -d "$dir_to_remove" ]]; then
    rm -dr "$binDir"
fi

$scriptDir/../github/download-release.ps1 -Repo tedchamb/logfmtpp -Name logfmtpp -Destination "$binDir"

$toolPath = "$binDir/logfmtpp"
chmod +x "$toolPath"

symlinkPath="/usr/local/bin/$(basename "$toolPath")"

if [[ ! -L "$symlinkPath" ]]; then
    echo "Adding symlink to $toolPath at $symlinkPath"
    sudo ln -s "$(realpath "$toolPath")" "$symlinkPath"
else
    echo "Path for symlink already exists: $symlinkPath"
fi
