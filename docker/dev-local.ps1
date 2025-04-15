# dev-local.ps1
param (
        [switch]$detach,
        [switch]$kill,
        [int]$port=8000,
        [string]$name='club-container'
      )

$ErrorActionPreference = "Stop"

$detachPreference=""
if ( $detach ) {
    $detachPreference="-d"
}

Write-Host "Stopping any currently running containers,,,"
try {
    docker stop ${name} *>$null
    docker rm ${name}   *>$null
} catch {}

if ( $kill ) { return }

Write-Host "Building container image,,,"
docker build -t nightclub-site .

Write-Host "Running container,,,"
docker run ${detachPreference} -p ${port}:${port} `
--env-file .env `
-v ${PWD}:/app `
--name ${name} `
nightclub-site
