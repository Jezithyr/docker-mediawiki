#!/bin/sh
set -eu
oldDir="$PWD"
scriptDir=$(dirname "$0")
cd $scriptDir
cd ..
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <service name>" >&2
  echo "where <service name> is the name of the service in your docker-compose.yaml" >&2
  cd $oldDir
  exit 1
fi

MW_SERIVCENAME=$1

docker compose exec ${MW_SERIVCENAME} bash
cd $oldDir