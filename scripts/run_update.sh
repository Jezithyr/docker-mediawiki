#!/bin/sh
set -eu
oldDir="$PWD"
scriptDir=$(dirname "$0")
cd $scriptDir
cd ..
if [ "$#" -ne 1 ]; then
  echo "No service specified running update on ALL wikis" >&2
  containerNames=$(docker compose ps --services)
  for containerName in $containerNames; do
    if (docker compose exec $containerName  test -f /var/www/mediawiki/maintenance/update.php); then 
		echo "Running update for $containerName"
		docker compose exec $containerName  php /var/www/mediawiki/maintenance/update.php --quick
	fi
	done
  cd $oldDir
  exit 0
fi

WIKISERVICE=$1
if (docker compose exec $WIKISERVICE test -f /var/www/mediawiki/maintenance/update.php); then 
	docker compose exec $WIKISERVICE php /var/www/mediawiki/maintenance/update.php --quick
else
	echo "$WIKISERVICE is not a mediawiki container"
	cd $oldDir
	exit 1
fi
cd $oldDir