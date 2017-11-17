#!/bin/bash

VER=$(wget -O - https://github.com/mozilla/geckodriver/releases/latest 2>/dev/null | grep "Release v"  | awk -F "Release v" '{print $2}' | awk -F " " '{print $1}')
LINK_PREFIX="https://github.com/mozilla/geckodriver/releases/download"
# https://github.com/mozilla/geckodriver/releases/download/v0.19.1/geckodriver-v0.19.1-linux64.tar.gz

wget $LINK_PREFIX"/v"$VER"/geckodriver-v"$VER"-linux64.tar.gz"
