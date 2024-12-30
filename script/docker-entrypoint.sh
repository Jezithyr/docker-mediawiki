#!/bin/bash
echo "checking skins"
if [ -z "${MEDIAWIKI_ENABLED_SKINS}" ]; then
	MEDIAWIKI_ENABLED_SKINS=Timeless
fi
SKINSREPO=$(curl https://extdist.wmflabs.org/dist/skins/| awk 'BEGIN { FS = "\""  } ; {print $2}')
for skin in $MEDIAWIKI_ENABLED_SKINS; do
	DIRECTORY="/var/www/html/skins/$skin"
	if [ ! -d "$DIRECTORY" ] ; then
		echo "$skin is not installed, installing!"
		FILENAME=`echo "$SKINSREPO" | grep ^${skin}-REL${WIKI_VERSION_STR}`		
		echo "skin found: $FILENAME"		
		if [ -n "{$FILENAME}" ]; then
			mkdir DIRECTORY
			curl -Ls https://extdist.wmflabs.org/dist/skins/$FILENAME | tar xz -C /var/www/html/skins;
		fi			
	fi
done

echo "checking extensions"
if [ -n "${MEDIAWIKI_ENABLED_EXTENSIONS}" ]; then
	EXTENSIONS_REPO=$(curl https://extdist.wmflabs.org/dist/extensions/ | awk 'BEGIN { FS = "\""  } ; {print $2}' )

	for extension in $MEDIAWIKI_ENABLED_EXTENSIONS; do
		DIRECTORY="/var/www/html/extensions/$extension"
		if [ ! -d "$DIRECTORY" ] ; then
			echo "$extension is not installed, installing!"
			FILENAME=`echo "$EXTENSIONS_REPO" | grep ^${extension}-REL${WIKI_VERSION_STR}`	
			echo "extension found: $FILENAME"		
			if [ -n "{$FILENAME}" ]; then
				mkdir DIRECTORY
				curl -Ls https://extdist.wmflabs.org/dist/extensions/$FILENAME | tar xz -C /var/www/html/extensions;
			fi			
		fi
	done
fi
exec /usr/local/bin/docker-php-entrypoint "$@"
