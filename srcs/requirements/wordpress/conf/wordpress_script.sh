#!/bin/bash

# Descargar la ultima version de WordPress
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
rm -rf latest.tar.gz

# Actualizar el archivo de configuracion por el nuevo descargado
rm -rf /etc/php/7.3/fpm/pool.d/www.conf
mv ./www.conf /etc/php/7.3/fpm/pool.d/

# Sustituir las lineas de wp-config.php por los datos de MariaDB
cd /var/www/html/wordpress
sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
mv wp-config-sample.php wp-config.php

# Permitir que se ejecuten comandos al finalizar
exec "$@"