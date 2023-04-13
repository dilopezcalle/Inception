# Penultima imagen de Debian
FROM debian:buster

# Actualizar e instalar servidor y cliente de mariadb (para copiar mariadb-client)
RUN apt-get update -y && apt-get -y install mariadb-server

# Crear el directorio donde se guardará los sockets de la base de datos
RUN mkdir -p /var/run/mysqld

# Asignar a todos los archivos como propietario al 
# usuario 'mysql' y grupo 'mysql' del directorio
RUN chown -R mysql:mysql /var/run/mysqld

# Dar todos los permisos a todos los usuarios en el directorio
RUN chmod 777 /var/run/mysqld

# Indicar que puerto usa el contenedor (no lo publica)
EXPOSE 3306

# Copiar el script que crea la base de datos y dar permisos de ejecución
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./conf/mariadb_script.sh /usr/local/bin/mariadb_script.sh
RUN chmod +x /usr/local/bin/mariadb_script.sh

# Ejecutar el script
ENTRYPOINT ["mariadb_script.sh"]

# Inicar mariadb y permitir que la base de datos se escuche desde cualquier sitio
CMD ["mysqld", "--bind-address=0.0.0.0"]