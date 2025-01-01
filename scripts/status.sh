#!/bin/sh
set -eu
oldDir="$PWD"
scriptDir=$(dirname "$0")
cd $scriptDir
cd ..
docker compose ps --all
cd $oldDir