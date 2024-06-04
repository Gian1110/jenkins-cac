# Usar la imagen oficial de Nginx como base
FROM nginx

# Copiar el archivo HTML "Hola Mundo" al directorio de HTML predeterminado de Nginx
COPY index.html /usr/share/nginx/html/

ENTRYPOINT ["nginx", "-g", "daemon off;"]