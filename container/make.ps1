param (
    [Parameter(Mandatory=$false)]
    [ValidateSet("help", "build", "shell", "clean")]
    [string]$Option = "help",

    [Parameter(Mandatory=$false)]
    [string]$Runtime = $env:CONTAINER_RUNTIME
)

# Define variables
$CONTAINER_TAG = "debian-angular-dev:bookworm"
$NODE_MAJOR_VERSION = 24

# Autodetect container runtime (Docker or Podman). Can be overridden with
# the `CONTAINER_RUNTIME` environment variable or the `-Runtime` parameter.
if ($Runtime) {
    $CONTAINER_CMD = $Runtime
} else {
    if (Get-Command docker -ErrorAction SilentlyContinue) {
        $CONTAINER_CMD = "docker"
    } elseif (Get-Command podman -ErrorAction SilentlyContinue) {
        $CONTAINER_CMD = "podman"
    } else {
        Write-Error "Neither 'docker' nor 'podman' was found in PATH. Install one or set CONTAINER_RUNTIME."
        exit 1
    }
}

# Define the help function
function Show-Help {
    Write-Output "build  - (re)build container $CONTAINER_TAG."
    Write-Output "shell  - run container with shell and current directory mounted as /workspace."
    Write-Output "clean  - remove container image $CONTAINER_TAG."
}

# Define the build function
function Build-Container {
    & $CONTAINER_CMD build `
        -f Dockerfile `
        --build-arg NODE_MAJOR=$NODE_MAJOR_VERSION `
        -t $CONTAINER_TAG
}

# Define the shell function
function Run-Shell {
    & $CONTAINER_CMD run `
        --rm -it `
        -v "..:/workspace" `
        -p 4200:4200 `
        --network bridge `
        $CONTAINER_TAG
}

# Define the clean function
function Clean-Container {
    & $CONTAINER_CMD rmi -f $CONTAINER_TAG 2>$null
}

switch ($Option) {
    "help"  { Show-Help }
    "build" { Build-Container }
    "shell" { Run-Shell }
    "clean" { Clean-Container }
    default  { Write-Output "Invalid option. Use 'help' to see available options." }
}