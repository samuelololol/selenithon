#!/bin/bash

# scp
docker-machine scp docker@docker:"$@" .
