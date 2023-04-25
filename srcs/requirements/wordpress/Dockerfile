# Penultima imagen de Debian
FROM debian:buster

# Actualizar e instalar las siguientes herramientas
# wget:         Herramienta para descargar archivos desde Internet
# php:          Lenguaje de programación utilizado en aplicaciones web
# php-cgi:      Interactuar con el servidor web para ejecutar scripts de PHP
# php-mysql:    Comunicación con bases de datos MySQL
# php-fpm:      Mejorar el rendimiento de las aplicaciones web
# php-pdo:      Proporciona capa de abstracción para acceder a bases de datos
# php-gd:       Manipulación de imágenes
# php-cli:      Interfaz de línea de comandos de PHP
# php-mbstring: Extensión de PHP para la manipulación de caracteres multibyte

RUN apt-get update -y && apt-get -y install \
curl wget php php-cgi php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/local/bin/wp

# Crear la carpeta donde habilitará php start
RUN mkdir /run/php

# # Copiar el archivo de configuración de WordPress
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

# Copiar y ejecutar el script 
COPY ./conf/wordpress_script.sh /usr/local/bin/wordpress_script.sh
RUN chmod +x /usr/local/bin/wordpress_script.sh
ENTRYPOINT ["wordpress_script.sh"]

# # Cambiar el espacio de trabajo
WORKDIR /var/www/html/

# # Indicar que puerto usa el contenedor (no lo publica)
EXPOSE 9000

# # Iniciar el proceso de PHP-FPM en primer plano
# # y procesar las solicitudes de PHP entrantes
CMD ["/usr/sbin/php-fpm7.3", "-F"]