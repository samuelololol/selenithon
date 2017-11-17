#!/bin/bash

# global
docker-machine ssh docker sudo rm -rf /app

# home
docker-machine ssh docker rm -rf /home/docker/app/
docker-machine ssh docker mkdir /home/docker/app/

# scp
docker-machine scp -r . docker@docker:/home/docker/app/
docker-machine ssh docker rm -rf /home/docker/app/.git
docker-machine ssh docker sudo cp -r /home/docker/app /app

# venv
docker-machine ssh docker mkdir -p /home/docker/.virtualenvs/
docker-machine ssh docker rm -rf /home/docker/.virtualenvs/venv-docker-machine
docker-machine scp -r ~/.virtualenvs/venv-docker-machine docker@docker:/home/docker/.virtualenvs/
