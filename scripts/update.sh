#!/bin/sh
set -eu
oldDir="$PWD"
scriptDir=$(dirname "$0")
cd $scriptDir
cd ..
if [ "$#" -ne 1 ]; then
  echo "No wiki service specified, you must specify a wiki service to update" >&2
  cd $oldDir
  exit 0
fi

WIKISERVICE=$1
docker compose exec $WIKISERVICE php /var/www/html/maintenance/run.php update --quick
cd $oldDir