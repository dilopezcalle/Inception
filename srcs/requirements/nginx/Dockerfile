# Penultima imagen de Debian
FROM debian:buster

ARG PRIVATE_CERT_DIR
ARG PUBLIC_CERT_DIR

# Actualizar e instalar nginx y openssl
RUN apt-get -y update && apt-get install -y nginx && apt-get install openssl -y

# Generar certificado SSL propio
# req -x509:        Indica que se creará un certificado autofirmado
# -newkey rsa:4096: Genera una nueva clave privada RSA de 4096 bits
# -nodes:           Indica que no se cifrará la clave privada
# -keyout:          Nombre del archivo de la clave privada
# -out:             Nombre del certificado
# -subj:            Información para el certificado
# -days 365:        Número de días de validez del certificado

RUN openssl req -x509 -newkey rsa:4096 -nodes -keyout ${PRIVATE_CERT_DIR} \
    -out ${PUBLIC_CERT_DIR} -subj "/C=ES/L=URDULIZ/O=42/OU=dilopez-/CN=dilopez-.42.fr" -days 365

# Copiar la configuración del nginx al contenedor
COPY ./conf/nginx.conf /etc/nginx/sites-available/default

# Indicar que puerto usa el contenedor (no lo publica)
EXPOSE 443

# nginx -g 'daemon off;': Inicia el servidor web en primer plano
CMD ["nginx", "-g", "daemon off;"]