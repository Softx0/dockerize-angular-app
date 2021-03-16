#Primera Etapa
# Utilizamos una imagen de Node
FROM node:10-alpine as build-step

# Creamos y copiamos el código de la aplicación en una carpeta llamada app
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app

# Instalamos las dependencias del archivo package.json
RUN npm install
COPY . /app

# Creamos los archivos de producción usando la imagen de Node
RUN npm run build --prod

#Segunda Etapa
# Utilizamos una imagen del servidor de Nginx
FROM nginx:1.17.1-alpine

# Si estas utilizando otra aplicacion cambia PokeApp por el nombre de tu app
# Copiamos los archivos de producción de app/dist/{{nombreApp}} a la ruta /usr/share/nginx/html.
COPY --from=build-step /app/dist/PokeApp /usr/share/nginx/html

# Fin
