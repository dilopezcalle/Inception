# Penultima imagen de Debian
FROM debian:buster

# Actualizar e instalar nginx y openssl
RUN apt -y update && apt install -y nginx && apt install openssl -y

# Generar certificado SSL propio
# req -x509:        Indica que queremos crear un certificado autofirmado
# -newkey rsa:4096: Genera una nueva clave privada RSA de 4096 bits
# -nodes:           Indica que no se cifrará la clave privada
# -keyout:          Nombre del archivo de la clave privada
# -out:             Nombre del certificado
# -subj:            Información para el certificado
# -days 365:        Número de días de validez del certificado

RUN openssl req -x509 -newkey rsa:4096 -nodes -keyout /etc/ssl/private/nginx-private-key.pem -out /etc/ssl/certs/nginx-certificate-key.pem -subj "/C=ES/L=URDULIZ/O=42/OU=dilopez-/CN=dilopez-.42.fr" -days 365

COPY index.html /var/www/html/

#Copy the new configuration inside nginx
COPY ./conf/nginx.conf /etc/nginx/sites-available/default

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]