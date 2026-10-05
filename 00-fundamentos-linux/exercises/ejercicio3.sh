# EJERCICIO 1
#!/bin/bash
# Asignamos el primer parámetro a la variable 'texto' directamente
texto=$1

# Comprobamos si la variable ha quedado vacía
if [ "$texto" == "" ]; then
    # Si está vacía, aplicamos el texto por defecto
    texto="Que me gusta la bash!!!!"
fi

# Crear la jerarquía de directorios (el flag -p ignora si ya existen)
mkdir -p foo/dummy foo/empty

# Crear file1.txt e introducirle el texto asignado
echo "$texto" > foo/dummy/file1.txt

# Crear file2.txt completamente vacío (cumpliendo el Ejercicio 1 estrictamente)
touch foo/dummy/file2.txt

# EJERCICIO 2

# Volcar (sobrescribir) el contenido de file1.txt en file2.txt
cat foo/dummy/file1.txt > foo/dummy/file2.txt

# Mover file2.txt a su ubicación final en la carpeta empty
mv foo/dummy/file2.txt foo/empty/
