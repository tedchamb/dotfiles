#!/usr/bin/env pwsh

$env:AzureSubscriptionId = '8a53cb9a-a3a5-4602-aa2d-8c171edde3c7'

if ($env:CODESPACES -eq 'true') {
    # Start-Actions
    function global:sa { zsh -c "unset SKYRISEV3 && $env:GITHUB_PATH/script/actions/start-actions" }

    # New Codespace Setup
    function global:ncs {
        if (-not (Test-Path "$env:SKYRISE_PATH/../bin" -PathType Container)) {
            src
            b
        }
        zsh -c "unset SKYRISEV3 && cd '$env:SKYRISE_PATH' && script/setup-codespaces-runner.ps1"
        zsh -c "cd '$env:LAUNCH_PATH' && script/setup --force"
        sa
    }
}

if ($env:SKYRISEV3 -eq 'true') {
    # Build Run L0s
    function global:brl0 {
        b
        if ($LastExitCode -eq 0) {
            l0
        }
    }

    # Build Run L1s
    function global:brl1 {
        b
        if ($LastExitCode -eq 0) {
            l1
        }
    }
}