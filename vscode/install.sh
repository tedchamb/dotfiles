#!/usr/bin/env bash

# Installs my VS Code extensions that are not on the Marketplace, from the
# .vsix attached to their latest GitHub release. Skips when VS Code is absent.

set -e

codeCli=$(command -v code || true)
if [[ -z "$codeCli" && -x "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]]; then
    # VS Code is installed but its shell command has not been added to PATH yet.
    codeCli="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
fi

if [[ -z "$codeCli" ]]; then
    echo "VS Code not found; skipping VS Code extensions"
    exit 0
fi

# installExtensionFromGitHubRelease <owner/repo> <publisher.extension> <asset name>
installExtensionFromGitHubRelease() {
    local repo=$1
    local extensionId=$2
    local assetName=$3

    # The latest-release page redirects to /releases/tag/<tag>; the tag is the version with a "v" prefix.
    local latestTag
    latestTag=$(curl -fsSI --retry 5 -o /dev/null -w '%{redirect_url}' "https://github.com/$repo/releases/latest" | sed 's#.*/tag/##')
    if [[ -z "$latestTag" ]]; then
        echo "Could not find the latest release of $repo"
        return 1
    fi
    local latestVersion=${latestTag#v}

    local installedVersion
    installedVersion=$("$codeCli" --list-extensions --show-versions 2>/dev/null | awk -F@ -v id="$extensionId" '$1 == id { print $2 }')
    if [[ "$installedVersion" == "$latestVersion" ]]; then
        echo "$extensionId $installedVersion is already installed"
        return 0
    fi

    echo "Installing $extensionId $latestVersion from https://github.com/$repo/releases/tag/$latestTag"
    local tempDir
    tempDir=$(mktemp -d)
    curl -fsSL --retry 5 -o "$tempDir/$assetName" "https://github.com/$repo/releases/download/$latestTag/$assetName"
    "$codeCli" --install-extension "$tempDir/$assetName" --force
    rm -rf "$tempDir"
}

installExtensionFromGitHubRelease tedchamb/vscode-pinpoint tedchamb.pinpoint pinpoint.vsix
