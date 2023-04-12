#!/bin/bash

# Este script crea una base de datos de MySQL,
# creación y asignación de permisos a un usuario,
# y cambia la contraseña del usuario root

mysql_install_db

# Iniciar el servicio
/etc/init.d/mysql start

mysql_secure_installation <<_EOF_

Y
$MYSQL_PASSWORD_ROOT
$MYSQL_PASSWORD_ROOT
Y
n
Y
Y
_EOF_

# Crear un .sql con las instrucciones a ejecutar
# echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE ;" > db.sql
# echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> db.sql
# echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' ;" >> db.sql
# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD_ROOT' ;" >> db.sql
# echo "FLUSH PRIVILEGES;" >> db.sql

# Modificar la contraseña del usuario administrador
echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_PASSWORD_ROOT';" | mysql -uroot
echo "FLUSH PRIVILEGES;" | mysql -uroot

# Crear una nueva base de datos si no existe
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" | mysql -uroot
# Crear un usuario con el login y contraseña que se especifiquen
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" | mysql -uroot
# Dar todos los privilegos de la base de datos creada al usuario creado
echo "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -uroot
# Actualizar los permisos
echo "FLUSH PRIVILEGES;" | mysql -uroot

# Detener el servicio
/etc/init.d/mysql stop
# kill $(cat /var/run/mysqld/mysqld.pid)

# Permitir que se ejecuten comandos al finalizar
exec "$@"