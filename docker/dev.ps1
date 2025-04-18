# dev-local.ps1
param (
        [switch]$local,
        [switch]$kill,
        [switch]$dryRun,
        [ValidateSet("all", "nightclub-site", "content-server", "jukebox-api")]
        [string]$target="all"
      )

$ErrorActionPreference = "Stop"
$PORT_SITE = "8080"
$PORT_CONTENT_API = "9090"
$PORT_JUKEBOX_API = "4040"
$projContainerMap = @{"nightclub-site"="club-container"; "content-server"="content-container"; "jukebox-api"="jukebox-api"}

Function Get-DockerNormalizedPath {
    param ([string]$path)
    return (Resolve-Path $path).Path -replace '\\', '/'
    }

Function Build {
    param (
        [string]$target
          )

    if ( $target -eq "all" ) {
        Build -target "nightclub-site"
        Build -target "content-server"
        Build -target "jukebox-api"
        return
    }

    if ( $target -eq "nightclub-site" ) {
        $projectroot = "./"
        $port = $PORT_SITE

        Write-Host "Collecting static files,,,"
        python manage.py collectstatic --clear --no-input

    } elseif ( $target -eq "content-server" ) {
        $projectroot = "./static_content_server/"
        $port = $PORT_CONTENT_API
    } elseif ( $target -eq "jukebox-api" ) {
        $projectroot = "./jukebox-api/"
        $port = $PORT_JUKEBOX_API
    }

    pushd $projectroot

    # normalize path for docker
    $hostroot   = Get-DockerNormalizedPath ${PWD}
    $dockerfile = "$hostroot/Dockerfile"
    $envfile    = "$hostroot/.env"

    Write-Host "Building container image,,,"
    Write-Host "docker build -f $dockerfile -t $target ."
    if ( -Not $dryRun ) {
        docker build -f $dockerfile -t $target .
    }

    # Building docker run args
    $runArgs = @(
    "run",
    "-d",
    "-p", "${port}:${port}",
    "--env-file", $envfile
    )
    if ( $local ) {
        $runArgs += "-v"
        $runArgs += "${hostroot}:/app"
    }

    $runArgs += @(
        "--name", $projContainerMap[$target],
        $target
    )

    Write-Host "Running container,,,"
    Write-Host ("docker " + $($runArgs -join ' '))
    if ( -Not $dryRun ) {
        docker @runArgs
    }

    popd

    return
}

if ( -Not $dryRun ) {
    Write-Host "Stopping+removing any currently running containers,,,"
    try {
        docker ps -q | ForEach-Object { docker stop $_ }
        docker ps -a -q | ForEach-Object { docker rm $_ }
    } catch {}

    if ( $kill ) { return }
}

Build -target $target
