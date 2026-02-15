# angular-dev

Angular-dev is a lightweight repository to capture information, tooling and
best-practices for Angular development. It includes Docker-based development
environment helpers under the `podman/` subdirectory.

## Features

- Debian Bookworm base image with Node.js and Angular CLI

## Quickstart

Build the development podman image (defaults shown):

```bash
podman build -t debian-angular-dev:bookworm -f podman/Dockerfile
```

Run the development container (mounts current repo into `/workspace` and
creates a matching non-root user inside the container):

```bash
podman run --rm -it \
    -v "$PWD":/workspace \
    -p 4200:4200 \
    debian-angular-dev:bookworm
```

## Contributing

Contributions, corrections and suggestions are welcome. Please open an issue
or submit a pull request with a clear description of the change.

## License

This project is licensed under the MIT License — see the `LICENSE` file for
details.

