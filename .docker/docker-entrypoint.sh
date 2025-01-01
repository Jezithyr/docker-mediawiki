#!/bin/bash
echo "fetching repositories"
SKINSREPO=$(curl https://extdist.wmflabs.org/dist/skins/| awk 'BEGIN { FS = "\""  } ; {print $2}')
EXTENSIONS_REPO=$(curl https://extdist.wmflabs.org/dist/extensions/ | awk 'BEGIN { FS = "\""  } ; {print $2}' )
echo "checking skins"
if [ -z "${MEDIAWIKI_ENABLED_SKINS}" ]; then
	MEDIAWIKI_ENABLED_SKINS=Timeless
fi
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
if [ "$MEDIAWIKI_MOBILE_FRONTEND_ENABLED" = true ]; then 
	if [ ! -d "/var/www/html/extensions/MobileFrontend" ] ; then
			echo "MobileFrontend is not installed, installing!"
			FILENAME=`echo "$EXTENSIONS_REPO" | grep ^MobileFrontend-REL${WIKI_VERSION_STR}`	
			echo "extension found: $FILENAME"		
			if [ -n "{$FILENAME}" ]; then
				mkdir DIRECTORY
				curl -Ls https://extdist.wmflabs.org/dist/extensions/$FILENAME | tar xz -C /var/www/html/extensions;
			fi			
		fi
fi
echo "checking extensions"
if [ -n "${MEDIAWIKI_ENABLED_EXTENSIONS}" ]; then
	

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
chmod -R 775 /config

exec /usr/local/bin/docker-php-entrypoint "$@"
