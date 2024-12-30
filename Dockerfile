FROM mediawiki

ENV WIKI_VERSION_STR=1_42

COPY script/docker-entrypoint.sh /entrypoint.sh
COPY script/LocalSettings.template.php /var/www/html/LocalSettings.php
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]