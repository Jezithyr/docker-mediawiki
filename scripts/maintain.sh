#!/bin/sh
set -eu
oldDir="$PWD"
scriptDir=$(dirname "$0")
cd $scriptDir
cd ..
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <wiki service> <maintenance command>" >&2
  echo "where <maintenance command> is any of these https://www.mediawiki.org/wiki/Manual:Maintenance_scripts/List_of_scripts" >&2
  cd $oldDir
  exit 0
fi

WIKISERVICE=$1
SCRIPT=$2
docker compose exec $WIKISERVICE php /var/www/html/maintenance/run.php $SCRIPT --quick
cd $oldDir