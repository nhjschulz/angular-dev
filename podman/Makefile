
CONTAINER_TAG=debian-angular-dev:bookworm
NODE_MAJOR_VERSION=24

.PHONY: help build clean shell

help:
	@echo "make build  - (re)build container $(CONTAINER_TAG)".
	@echo "make shell  - run container with shall and current directory mounted as /workspace."
	@echo "make clean  - remove container image $(CONTAINER_TAG)."

build:
	podman build \
		-f Dockerfile \
		--build-arg NODE_MAJOR=$(NODE_MAJOR_VERSION) \
		-t $(CONTAINER_TAG)

shell:
	podman run \
		--rm -it \
  		-v "$PWD":/workspace \
  		-p 4200:4200  \
  		$(CONTAINER_TAG)

clean::
	podman rmi -f $(CONTAINER_TAG) || true