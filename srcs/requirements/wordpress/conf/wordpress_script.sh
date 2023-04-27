#!/bin/bash

mkdir -p /var/www/html
cd /var/www/html
rm -rf *

wp core download --allow-root

# Sustituir las lineas de wp-config.php por los datos de MariaDB
sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
mv wp-config-sample.php wp-config.php

wp core install --url=$WP_DOMAIN/ --title=$WP_TITLE --admin_user=$WP_USER --admin_password=$WP_PASSWORD --admin_email=$WP_MAIL --skip-email --allow-root
wp theme install astra --activate --allow-root
wp plugin update --all --allow-root

# Permitir que se ejecuten comandos al finalizar
exec "$@"