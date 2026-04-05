# Makefile for building and running the Angular development container
# using Podman or Docker.

# Container settings
CONTAINER_FROM ?= debian:bookworm-slim
CONTAINER_TAG ?= debian-angular-dev:bookworm
CONTAINER_PORT ?= 4200

# Node.js major version
NODE_MAJOR_VERSION ?= 24

# Internal variables
ROOT_DIR := $(shell git rev-parse --show-toplevel 2>/dev/null || echo .)
ENGINE :=$(shell which podman 2>/dev/null || which docker 2>/dev/null)
ifeq ($(ENGINE),)
	$(error No container engine found. Please install Podman or Docker.)
endif

.PHONY: help build clean shell

help:
	@echo "make build  - (re)build container $(CONTAINER_TAG)".
	@echo "make shell  - run container with shall and current directory mounted as /workspace."
	@echo "make clean  - remove container image $(CONTAINER_TAG)."

build:
	$(ENGINE) build \
		-f Dockerfile \
		--build-arg CONTAINER_FROM=$(CONTAINER_FROM) \
		--build-arg NODE_MAJOR=$(NODE_MAJOR_VERSION) \
		-t $(CONTAINER_TAG)

shell:
	$(ENGINE) run \
		--rm -it \
  		-v $(ROOT_DIR):/workspace \
  		-p $(CONTAINER_PORT):4200 \
  		$(CONTAINER_TAG)

clean::
	-$(ENGINE) rmi -f $(CONTAINER_TAG) || true