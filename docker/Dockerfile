FROM mediawiki

ENV WIKI_VERSION_STR=1_42

COPY docker-entrypoint.sh /entrypoint.sh
COPY LocalSettings.template.php /var/www/html/LocalSettings.php
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]