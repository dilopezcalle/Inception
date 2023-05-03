#!/bin/bash

# Este script crea una base de datos de MySQL,
# creación y asignación de permisos a un usuario,
# y cambia la contraseña del usuario root

# Iniciar el servicio
mysql_install_db
service mysql start

# Crear una nueva base de datos si no existe
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" | mysql -uroot
# Crear el usuario root
echo "CREATE USER IF NOT EXISTS '$MYSQL_ROOT_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" | mysql -uroot
echo "GRANT ALL ON *.* TO '$MYSQL_ROOT_USER'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" | mysql -uroot
# Crear un usuario con el login y contraseña que se especifiquen
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -uroot
# Dar todos los privilegos de la base de datos creada al usuario creado
echo "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -uroot
# Suprimir la cuenta de root por defecto
DROP USER 'root'@'localhost' | mysql -uroot;
# Actualizar los permisos
echo "FLUSH PRIVILEGES;" | mysql -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD

# Detener el servicio para que aplique los cambios de contraseñas
/etc/init.d/mysql stop

# Permitir que se ejecuten comandos al finalizar
exec "$@"