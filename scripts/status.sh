#!/bin/sh
set -eu
oldDir="$PWD"
scriptDir=$(dirname "$0")
cd "../$scriptDir"
docker compose container ps --all --services
cd $oldDir