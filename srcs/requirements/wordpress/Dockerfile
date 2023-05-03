# Penultima imagen de Debian
FROM debian:buster

# Actualizar e instalar las siguientes herramientas
# php-mysql:    Comunicación con bases de datos MySQL
# php-fpm:      Mejorar el rendimiento de las aplicaciones web

RUN apt-get update -y && apt-get -y install \
php-fpm php-mysql curl netcat

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/local/bin/wp

# Crear la carpeta donde habilitará php start
RUN mkdir /run/php

# Copiar el archivo de configuración de WordPress
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

# Copiar el script que instala y configura WordPress
COPY ./conf/wordpress_script.sh /usr/local/bin/wordpress_script.sh
RUN chmod +x /usr/local/bin/wordpress_script.sh

# Cambiar el espacio de trabajo
WORKDIR /var/www/html

# Indicar que puerto usa el contenedor (no lo publica)
EXPOSE 9000

# Ejecutar el script de WordPress, iniciar el proceso de PHP-FPM
# en primer plano y procesar las solicitudes de PHP entrantes
CMD ["sh", "-c", "wordpress_script.sh && /usr/sbin/php-fpm7.3 -F"]