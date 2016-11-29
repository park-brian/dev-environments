#!/bin/bash

## This script mounts node_modules as a temporary directory to avoid creating
## symlinks on windows hosts. You wil need to run this every time you start
## a new machine

## To use this script, either run it in the project directory, or specify
## it as an argument: ./bootstrap.sh /vagrant/projects/demo

[[ ! -z $1 ]] && DIR="$1/node_modules" || DIR="$PWD/node_modules"
TMP="/tmp/$(date | md5sum | head -c10)/node_modules"

mkdir -p $DIR $TMP
sudo mount --bind $TMP $DIR
