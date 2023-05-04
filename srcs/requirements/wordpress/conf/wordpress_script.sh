#!/bin/bash

# Cambiar el espacio de trabajo
mkdir -p /var/www/html
cd /var/www/html
rm -rf *

# Definir tiempo máximo de espera
WAIT_TIME=${DB_WAIT_TIME:-60}

# Espera hasta que el servicio MariaDB este disponible en el puerto 3306
for i in $(seq 1 $WAIT_TIME); do
  nc -z mariadb 3306 && echo "El contenedor 'mariadb' está disponible." && break
  echo "Esperando que el contenedor 'mariadb' esté disponible..."
  sleep 1
done

wp core download --allow-root

# Sustituir las lineas de wp-config.php por los datos de MariaDB
sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
mv wp-config-sample.php wp-config.php

wp core install --url=$WP_DOMAIN/ --title=$WP_TITLE --admin_user=$WP_ROOT_USER --admin_password=$WP_ROOT_PASSWORD --admin_email=$WP_ROOT_MAIL --skip-email --allow-root
wp theme install astra --activate --allow-root
wp plugin update --all --allow-root --path=/var/www/html --dir=wp-content/themes

# Permitir que se ejecuten comandos al finalizar
exec "$@"