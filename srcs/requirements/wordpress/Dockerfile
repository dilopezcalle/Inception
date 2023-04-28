# Penultima imagen de Debian
FROM debian:buster

# Actualizar e instalar las siguientes herramientas
# php-mysql:    Comunicación con bases de datos MySQL
# php-fpm:      Mejorar el rendimiento de las aplicaciones web

RUN apt-get update -y && apt-get -y install \
php-fpm php-mysql curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/local/bin/wp

# Crear la carpeta donde habilitará php start
RUN mkdir /run/php

# Copiar el archivo de configuración de WordPress
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

# Cambiar el espacio de trabajo
RUN mkdir -p /var/www/html
WORKDIR /var/www/html
RUN rm -rf *

RUN wp core download --allow-root

ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_HOSTNAME
ARG MYSQL_DATABASE

# ENV MYSQL_USER=${MYSQL_USER}
# ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}
# ENV MYSQL_HOSTNAME=${MYSQL_HOSTNAME}
# ENV MYSQL_DATABASE=${MYSQL_DATABASE}

# Sustituir las lineas de wp-config.php por los datos de MariaDB
RUN sed -i "s/username_here/${MYSQL_USER}/g" wp-config-sample.php && \
    sed -i "s/password_here/${MYSQL_PASSWORD}/g" wp-config-sample.php && \
    sed -i "s/localhost/${MYSQL_HOSTNAME}/g" wp-config-sample.php && \
    sed -i "s/database_name_here/${MYSQL_DATABASE}/g" wp-config-sample.php && \
    mv wp-config-sample.php wp-config.php

# RUN wp core install --url=${WP_DOMAIN}/ --title=${WP_TITLE} --admin_user=${WP_USER} \
#     --admin_password=${WP_PASSWORD} --admin_email=${WP_MAIL} --skip-email --allow-root && \
#     wp theme install astra --activate --allow-root && \
#     wp plugin update --all --allow-root

# Indicar que puerto usa el contenedor (no lo publica)
EXPOSE 9000

# Iniciar el proceso de PHP-FPM en primer plano
# y procesar las solicitudes de PHP entrantes
CMD ["/usr/sbin/php-fpm7.3", "-F"]