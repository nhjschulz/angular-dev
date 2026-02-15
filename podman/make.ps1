param (
    [Parameter(Mandatory=$false)]
    [ValidateSet("help", "build", "shell", "clean")]
    [string]$Option = "help"
)

# Define variables
$CONTAINER_TAG = "debian-angular-dev:bookworm"
$NODE_MAJOR_VERSION = 24

# Define the help function
function Show-Help {
    Write-Output "build  - (re)build container $CONTAINER_TAG."
    Write-Output "shell  - run container with shell and current directory mounted as /workspace."
    Write-Output "clean  - remove container image $CONTAINER_TAG."
}

# Define the build function
function Build-Container {
    podman build `
        -f Dockerfile `
        --build-arg NODE_MAJOR=$NODE_MAJOR_VERSION `
        -t $CONTAINER_TAG
}

# Define the shell function
function Run-Shell {
    podman run `
        --rm -it `
        -v "..:/workspace" `
        -p 4200:4200 `
        --network bridge `
        $CONTAINER_TAG
}

# Define the clean function
function Clean-Container {
    podman rmi -f $CONTAINER_TAG -ErrorAction SilentlyContinue
}

switch ($Option) {
    "help"  { Show-Help }
    "build" { Build-Container }
    "shell" { Run-Shell }
    "clean" { Clean-Container }
    default  { Write-Output "Invalid option. Use 'help' to see available options." }
}