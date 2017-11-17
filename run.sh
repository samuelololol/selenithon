#!/bin/bash
docker run --rm -t $(tty &>/dev/null && echo "-i") \
        -e "SCREEN_WIDTH=${SCREEN_W}" \
        -e "SCREEN_HEIGHT=${SCREEN_H}" \
        -e "SCREEN_DEPTH=${SCREEN_D}" \
        -v "/home/docker/.virtualenvs/venv-docker-machine:/root/.virtualenvs/env" \
        -v "/app:/app" samuelololol/selenithon "$@"
#        -v "/app:/app" dse:v0.19.1 "$@"
