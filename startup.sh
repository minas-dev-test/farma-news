#!/bin/bash

echo "WordPress base Setup: $WORDPRESS_TITLE"
rm wp-config.php
sed -i '/exec "$@"/d' /usr/local/bin/docker-entrypoint.sh

echo "Waiting for the database on $WORDPRESS_DB_HOST"
wait-for-it $WORDPRESS_DB_HOST -t 0
docker-entrypoint.sh "$@"

echo "Custom setup"
rm -rf wp-content/themes
cp -rf /usr/src/farma/. wp-content
chown -R www-data:www-data wp-content

# TODO: Make auto-install optional
if ! $(wp --allow-root core is-installed); then

	cat <<EOF


Installing WordPress


USED SETTINGS: (don't lost it!)

URL: $WORDPRESS_URL
Title: $WORDPRESS_TITLE
Language: $WORDPRESS_LANGUAGE
Admin 
    User: $WORDPRESS_ADMIN_USER
    Password: $WORDPRESS_ADMIN_PASSWORD
    Email: $WORDPRESS_ADMIN_MAIL


EOF

	wp --allow-root core install --url="$WORDPRESS_URL" --title="$WORDPRESS_TITLE" --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_MAIL

	echo "Installing language"
	wp --allow-root language core install $WORDPRESS_LANGUAGE
	wp --allow-root language core activate $WORDPRESS_LANGUAGE

	echo "Configuring permalink"
	wp --allow-root option update permalink_structure '/%year%/%monthnum%/%day%/%postname%/'

	echo "Updating plugins"
	wp --allow-root plugin update --all

	echo "Activating theme"
	wp --allow-root theme activate farma-theme
else
	#TODO: Update url only if it has changed. See https://codex.wordpress.org/Changing_The_Site_URL#wp-cli
	wp --allow-root option update home "$WORDPRESS_URL"
	wp --allow-root option update siteurl "$WORDPRESS_URL"
fi

echo "Starting Server"
# DEBUG: Pause the script
# wait-for-it db:12345 -t 0
exec "$@"
