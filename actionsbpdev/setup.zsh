#!/usr/bin/env zsh

if [[ -a ~/.profile ]]; then
    source ~/.profile > /dev/null
    if [[ $BP_DEV = true ]]; then
        alias adn='cd ~/src/azdevnext/src && ./init.sh'

        mkdir -p ~/.dflogs
        if [[ ! -f ~/.dflogs/githubFeatureFlags.log ]]; then
            (
                cd $GITHUB_PATH
                bin/toggle-feature-flag enable actions_premium_runners -F actions_custom_image >> ~/.dflogs/githubFeatureFlags.log 2>&1
            )
        fi
    fi
fi
