#!/usr/bin/env bash

PWD=$(pwd)
DOCKER_CMD="docker run --rm -it -v $PWD:/app tf"
[ ! "$(docker images tf -q)" ] && docker build -t tf . && $DOCKER_CMD init /cloud-run
docker run --rm -it -v "$(pwd):/app" tf "$@"
