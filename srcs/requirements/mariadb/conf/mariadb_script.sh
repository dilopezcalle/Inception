#!/bin/bash

# Este script crea una base de datos de MySQL,
# creación y asignación de permisos a un usuario,
# y cambia la contraseña del usuario root

# Iniciar el servicio
mysql_install_db
service mysql start

# Crear una nueva base de datos si no existe
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" | mysql -uroot
# Crear un usuario con el login y contraseña que se especifiquen
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" | mysql -uroot
# Dar todos los privilegos de la base de datos creada al usuario creado
echo "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -uroot
# Modificar la contraseña del usuario administrador (no en localhost)
echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_PASSWORD_ROOT' ;" | mysql -uroot
# Actualizar los permisos
echo "FLUSH PRIVILEGES;" | mysql -uroot

# Detener el servicio para que aplique los cambios de contraseñas
/etc/init.d/mysql stop

# Permitir que se ejecuten comandos al finalizar
exec "$@"