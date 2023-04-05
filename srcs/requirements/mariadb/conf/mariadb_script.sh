#!/bin/bash

# Este script crea una base de datos de MySQL,
# creación y asignación de permisos a un usuario,
# y cambia la contraseña del usuario root
#mysql_install_db

# Iniciar el servicio
/etc/init.d/mysql start

# Crear un .sql con las instrucciones a ejecutar

# Crear una nueva base de datos si no existe
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE ;" > db.sql
# Crear un usuario con el login y contraseña que se especifiquen
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> db.sql
# Dar todos los privilegos de la base de datos creada al usuario creado
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' ;" >> db.sql
# Modificar la contraseña del usuario administrador
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD_ROOT' ;" >> db.sql
# Actualizar los permisos
echo "FLUSH PRIVILEGES;" >> db.sql

# Ejecitar el .sql en el servicio de MySQL
mysql < db.sql

# Detener el servicio
/etc/init.d/mysql stop

# Permitir que se ejecuten comandos al finalizar
exec "$@"