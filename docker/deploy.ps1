param (
        [ValidateSet("all", "nightclub-site", "content-server")]
        [string]$target = "all",
        [string]$version= "v1"
      )

$ErrorActionPreference = "Stop"
$deployRegion = "us-central1"
$project = "nightclub-reloaded"
$imageRepo = "$deployRegion-docker.pkg.dev/$project/nightclub-repo/"

function Deploy-CloudRun {
    param (
            [string]$service,
            [string]$image,
            [string]$port,
            [string]$inject=""
          )

    try {
        Write-Host "$inject"
        gcloud run deploy $service `
        --image $image `
        --platform managed `
        --region $deployRegion `
        --allow-unauthenticated `
        --set-env-vars=$inject `
        --port $port `
        --project $project
    } catch {
        Write-Error "Failed to deploy image $image"
    }
}

function Deploy-ContentServer {
    $service = "content-server"
    $image   = "${imageRepo}${service}:${version}"

    Write-Host "Building & pushing content-server image..."
    docker build --no-cache -f static_server/Dockerfile -t $image .
    docker push $image

    Deploy-CloudRun -service $service -image $image -port 9090

    try {
        $deployUrl = gcloud run services describe content-server `
        --platform managed `
        --region $deployRegion `
        --project $project `
        --format="value(status.url)"
    } catch {
        throw "Failed to retrieve content-server URL from Cloud Run"
    }
    Write-Host "Content server deployed at: $deployUrl"
    return $deployUrl
}

# @TODO: remove these hardcoded variables and test
function Deploy-NightclubSite {
    param (
            [string]$staticUrl = "https://content-server-255993342952.us-central1.run.app/",
            [string]$allowedHost = "nightclub-site-255993342952.us-central1.run.app"
          )
    $service = "nightclub-site"
    $image   = "${imageRepo}${service}:${version}"

    Write-Host "Building & pushing site image..."
    docker build --no-cache -t $image .
    docker push $image

    Deploy-CloudRun -service $service -image $image -port 8080 -inject "STATIC_URL=`"$staticUrl`",ALLOWED_HOSTS=`"$allowedHost`""
}

switch ($target) {
    "content-server"     { Deploy-ContentServer }
    "nightclub-site"     { Deploy-NightclubSite }
    "all"                {
        $staticUrl = Deploy-ContentServer
        Deploy-NightclubSite -staticUrl $staticUrl
    }
}
