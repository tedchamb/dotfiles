if (-not (Get-Module -ListAvailable -Name posh-git)) {
    Install-Module posh-git -Scope CurrentUser -Force -SkipPublisherCheck
} 

if (-not (Get-Module -ListAvailable -Name oh-my-posh)) {
    Install-Module oh-my-posh -Scope CurrentUser -Force -SkipPublisherCheck
}

if (-not (Get-Module -ListAvailable -Name PSReadLine)) {
    Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck
}

Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox

# $env:AzureSubscriptionId = "8a53cb9a-a3a5-4602-aa2d-8c171edde3c7"