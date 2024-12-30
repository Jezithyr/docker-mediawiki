# A simple media wiki docker-compose stack.

## To use:
1) Create a copy of docker-compose-example.yaml, and rename to it docker-compose.yaml
2) Configure your installation using the environment variables
- Make sure to include http or https in MEDIAWIKI_SITE_SERVER !
- Generate a secure 64-digit alphanumeric key for MEDIAWIKI_SECRET_KEY (You can also get one later from the generated LocalSettings.php)
- Generate/set a secure password in: MEDIAWIKI_UPGRADE_KEY for running web updates
3) Use docker compose build to prep the container and docker compose up -d to start the server
4) Go to http://localhost/w/mw-config and enter your MEDIAWIKI_UPGRADE_KEY to start the setup process
5) Go through the setup wizard until completion. You should download the LocalSettings.php file provided, as it can be used for reference to set environment variables.

## Details
Skins and Extensions can be automatically installed by specifying them in the MEDIAWIKI_ENABLED_SKINS and MEDIAWIKI_ENABLED_EXTENSIONS options respectively as space separated lists. You may also install Skins or Extensions manually by placing them in their respective folders. Not all Skins or Extensions are available on mediawiki's repositories and if any are not found, it will result in errors. To update/redownload an extension or skin, simply delete it's folder and restart the container. Skins and Extensions can be disabled by removing them from the active list, and this will not remove/delete them.