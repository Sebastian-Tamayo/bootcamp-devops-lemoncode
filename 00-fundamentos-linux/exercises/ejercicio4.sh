#!/bin/bash

# EJERCICIO 4: Búsqueda en página web

# 1. Guardamos la palabra que el usuario pasa como parámetro
texto=$1

# Definimos la URL de la página web a descargar
url="https://www.google.com"

# 2. Descargamos la web en un archivo llamado "web.txt" de forma silenciosa (-s)
curl -s "$url" > web.txt

# 3. Contamos las líneas donde aparece la palabra.
# Usamos '-a' para forzar a grep a leerlo como texto y evitar errores de binario.
conteo=$(grep -a -c "$texto" web.txt)

# 4. Comprobamos si el número de apariciones es igual a 0
if [ "$conteo" -eq 0 ]; then
    # Si es 0, significa que no existe en el texto
    echo "No se ha encontrado la palabra '$texto' en la página."
else
    # Si es distinto de 0, significa que sí existe
    echo "La palabra '$texto' aparece en $conteo líneas."
    
    echo "Esta es su primera aparición (Línea : Texto):"
    
    # Buscamos la primera aparición.
    grep -a -n -m 1 "$texto" web.txt
fi

#5. Borramos el archivo temporal para dejar el entorno limpio
rm web.txt 

