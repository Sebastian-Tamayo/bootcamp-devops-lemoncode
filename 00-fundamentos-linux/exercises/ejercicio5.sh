#!/bin/bash

# EJERCICIO 5: Igual que el 4, pero la URL también se pasa por parámetro

# Comprobamos que nos pasen exactamente 2 parámetros
if [ "$#" -ne 2 ]; then
    echo "Se necesitan únicamente dos parámetros para ejecutar este script"
    exit 1
fi

# Guardamos la URL y la palabra
url=$1
texto=$2

# Descargamos la web en un archivo
curl -s "$url" > web.txt

# Contamos cuántas veces aparece la palabra
conteo=$(grep -a -c "$texto" web.txt)

if [ "$conteo" -eq 0 ]; then
    echo "No se ha encontrado la palabra \"$texto\""
else
    # Sacamos el número de la primera línea donde aparece
    primera_linea=$(grep -a -n -m 1 "$texto" web.txt | cut -d: -f1)

    if [ "$conteo" -eq 1 ]; then
        echo "La palabra \"$texto\" aparece 1 vez"
        echo "Aparece únicamente en la línea $primera_linea"
    else
        echo "La palabra \"$texto\" aparece $conteo veces"
        echo "Aparece por primera vez en la línea $primera_linea"
    fi
fi

# Borramos el archivo temporal
rm web.txt
