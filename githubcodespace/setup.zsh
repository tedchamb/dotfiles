#!/usr/bin/env zsh

set -x

if [[ ! $CODESPACES = true ]]; then
  return
fi

if [[ ! $SKYRISE_PATH = true ]]; then
  return
fi

alias adn="cd $SKYRISE_PATH && ./init.sh"

mkdir -p ~/.dflogs
if [[ ! -f ~/.dflogs/githubFeatureFlags.log ]]; then
    (
        cd $GITHUB_PATH
        bin/toggle-feature-flag enable actions_premium_runners -F actions_custom_image >> ~/.dflogs/githubFeatureFlags.log 2>&1
    )
fi
