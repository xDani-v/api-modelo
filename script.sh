#!/bin/bash

# ID del archivo de Google Drive
file_id="1X-Q1v4_NtDzCHMi_lQM3xAvdrFhSrVbO"

# Nombre de archivo de destino
file_name="skin.h5"

# URL de descarga directa de Google Drive
download_url="https://drive.google.com/uc?id=18PhaN6hAVeEfTX-onAsSYOCD4YuTCWGX&export=download&confirm=t&uuid=f98c6d1b-a041-4c96-8c07-785bb09da383"

# Directorio de destino donde se guardará el archivo
destination_directory="./models/"

# Descarga el archivo desde Google Drive usando curl
echo "Descargando archivo desde Google Drive..."
curl -c /tmp/gcookie -s -L "$download_url" -o "$destination_directory/$file_name"

# Extrae el token de descarga
token="$(awk '/confirm=/{print $NF}' /tmp/gcookie)"

# Descarga el archivo con el token de confirmación
curl -Lb /tmp/gcookie "$download_url&confirm=$token" -o "$destination_directory/$file_name"

# Comprueba si la descarga fue exitosa
if [ -s "$destination_directory/$file_name" ]; then
    echo "Descarga exitosa: $destination_directory/$file_name"
else
    echo "Error en la descarga"
fi

# Limpia las cookies temporales
rm -f /tmp/gcookie
