#!/bin/sh
set -eu
oldDir="$PWD"
scriptDir=$(dirname "$0")
cd "../$scriptDir"

if [ "$#" -ne 1 ]; then
  databaseService="database"
  exit 1
fi
databaseService=$1
docker exec $databaseService sh -c "mysql -u root -p"
cd $oldDir