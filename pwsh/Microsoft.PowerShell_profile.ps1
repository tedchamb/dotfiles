#!/usr/bin/env pwsh

$env:AzureSubscriptionId = '8a53cb9a-a3a5-4602-aa2d-8c171edde3c7'

$cheatSheet = ""
if ($env:CODESPACES -eq 'true') {
    # Start-Actions
    function global:sa {
        zsh -c "unset SKYRISEV3 && $env:GITHUB_PATH/script/actions/start-actions"
    }

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

    # runner job agent logs
    function global:rjl {
        kubectl logs $(kubectl get pods -o name | grep 'pod/runner-job-agent-') --follow
    }

    # runner api server logs
    function global:ral {
        kubectl logs $(kubectl get pods -o name | grep 'pod/runner-api-server-') --follow
    }

    # faults in the host to Actions and Runner services
    # https://github.com/github/actions-dotnet/blob/main/script/autopath/faultInOrg
    function global:fig { faultInOrg github }
    function global:fia { faultInOrg actions }
    
    # Rerun dotfiles install
    function global:di { 
        zsh -c "cd '$env:DOTFILESPATH' && git pull && ./install.sh"
    }

    # run L2s in parallel
    function global:l2p {
        run_tests_parallel.ps1 "$env:BINARIESDIR/Runner.Service/Debug" 'GitHub.Actions.Runner.Service.L2.Tests.dll' '' "$env:BUILDDIR/Runner/Runner.L2.runsettings" 'Priority=1' '' "$env:BUILDDIR/../temp/L2"
    }

    # build deploy runner
    function global:bdr {
        b
        if ($LastExitCode -eq 0) {
            deploy runner -useexistingdatabases
        }
    }

    $cheatSheet += "
bdr     build deploy runner
di      dotfiles install latest
fia     faultInOrg actions
fig     faultInOrg github
l2p     run L2s in parallel
ncs     new codespace setup
ral     runner api server logs
rjl     runner job agent logs
sa      start actions
"
}

    $cheatSheet += "
k       kubectl
brl0    build and run l0
brl1    build and run l1"

# kubectl
function global:k {
    kubectl $args
}

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

function global:cheat {
    write-host $cheatSheet
}
