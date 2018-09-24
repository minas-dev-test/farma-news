#!/bin/bash
# echo "xxx" >> /var/www/xablau.txt
# echo "xxx" >> /var/www/html/xablau.txt
echo "WordPress base Setup $WORDPRESS_DB_USER"
rm wp-config.php
sed -i '/exec "$@"/d' /usr/local/bin/docker-entrypoint.sh
docker-entrypoint.sh "$@"
echo "Custom setup"
rm -rf wp-content/themes
cp -rf /usr/src/farma/. wp-content
if [ -e wp-config.php ]; then
    echo "Inserting configs"
    # echo "define('WP_USE_THEMES', false);" >> wp-config.php
    echo "define('WP_DEFAULT_THEME', 'farma-theme');" >> wp-config.php
    echo "$WORDPRESS_CUSTOM_CONFIG" >> wp-config.php
else
    echo "No wp-config.php file"
fi
echo "Starting Server"
exec "$@"