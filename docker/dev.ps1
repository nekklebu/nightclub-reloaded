# dev-local.ps1
param (
        [switch]$detach=$True,
        [switch]$local,
        [switch]$kill,
        [switch]$dryRun,
        [ValidateSet("all", "nightclub-site", "content-server")]
        [string]$target="all"
      )

$ErrorActionPreference = "Stop"
$PORT_SITE = "8080"
$PORT_SERV = "9090"
$detachPreference = if ( $detach ) { "-d" } else { "" }
$projContainerMap = @{"nightclub-site"="club-container"; "content-server"="content-container"}

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
        return
    }

    if ( $target -eq "nightclub-site" ) {
        $projectroot = "./"
        $port = $PORT_SITE

        Write-Host "Collecting static files,,,"
        python manage.py collectstatic --clear --no-input

    } elseif ( $target -eq "content-server" ) {
        $projectroot = "./static_content_server/"
        $port = $PORT_SERV
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
    $detachPreference,
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
