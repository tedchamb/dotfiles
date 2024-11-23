#!/usr/bin/env pwsh

param (
    [string]$Repo,
    [string]$Name,
    [string]$DestinationPath
)

function Invoke-RequestWithRetry {
    param([string]$Uri, [HashTable]$Headers, $Method, [string]$OutFile = $null)
    $maxAttempts = 5
    $count = 0
    $delayInSeconds = 1
    while ($count -lt $maxAttempts) {
        try {
            if ($OutFile) {
                $response = Invoke-WebRequest -Uri $Uri -Headers $Headers -OutFile $OutFile
            }
            else {
                $response = Invoke-RestMethod -Uri $Uri -Headers $Headers
            }
            break
        }
        catch {
            if ($count -eq $maxAttempts - 1) {
                throw
            }
            Write-Warning "Error invoking request - $Uri -> $_.Exception"
            Start-Sleep -Seconds $delayinSeconds
            $delayInSeconds *= 2
        }
        $count++
    }
    return $response
}

$tempDirectory = Join-Path ([System.IO.Path]::GetTempPath()) $Name
$extractedPath = Join-Path $tempDirectory 'extracted'

if (Test-Path -Path $tempDirectory -PathType Container) {
    Remove-Item $tempDirectory -Force -Recurse
}

New-Item -ItemType Directory -Path $tempDirectory

$downloadFileName = "$Name.zip"

$latestRelease = Invoke-RequestWithRetry -Uri "https://api.github.com/repos/$Repo/releases/latest" -Headers $gitHubHeaders

ForEach ($asset in $latestRelease.assets) {
    if ($asset.name -eq $downloadFileName) {
        $assetUrl = $asset.url
        break;
    }
}

Write-Host "Downloading latest version of $($Name): $($latestRelease.html_url)"

$archive = Join-Path $tempDirectory $downloadFileName

$downloadHeaders = @{
    'Accept' = 'application/octet-stream'
}
Invoke-RequestWithRetry -Uri $assetUrl -OutFile $archive -Headers $downloadHeaders
Expand-Archive -LiteralPath $archive -DestinationPath $DestinationPath

Remove-Item $tempDirectory -Force -Recurse
