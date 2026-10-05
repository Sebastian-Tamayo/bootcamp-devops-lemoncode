# Día I: Introducción a Docker 🐳 ✅

![Docker](imagenes/Contenedores%20I%20-%20Hello%20World%20-%20Lemoncode.jpeg)

¡Hola lemoncoders! 👋 Con este módulo arrancamos con los contenedores. Pero antes de nada es importante que eches un vistazo a los vídeos de introducción que hemos dejado preparados para ti en el Campus de Lemoncode.

## 🎬 Vídeos de la introducción en el campus

Se asume que has visto los siguientes vídeos para comenzar con este módulo:

| # | Tema |
|---|------|
| 1 | 📘 Teoría
| 2 | 🛠️ Demo: Instalar Docker Desktop en MacOS | 
| 3 | 🛠️ Demo: Instalar Docker Desktop en Windows | 
| 4 | 🧪 Demo: Mi primer contenedor con Docker Desktop | 
| 5 | 🔤 Demo: Cómo crear tus primeros contenedores desde el terminal de Docker Desktop |


Te he dejado marcada en la agenda 🍋📺 aquellas secciones que se tratan en los vídeos. Con el resto nos ponemos en la clase online.

## 📋 Agenda

- [🧰 Cómo instalar Docker en tu máquina local](#-cómo-instalar-docker-en-tu-máquina-local) 🍋📺
- [👀 Conociendo Docker desde Docker Desktop](#-conociendo-docker-desde-docker-desktop) 🍋📺
  - [🚀 Mi primer contenedor con un servidor web](#-mi-primer-contenedor-con-un-servidor-web) 🍋📺
- [🐳 Docker CLI](#-docker-cli) 🍋📺
- [Visual Studio Code y Docker](#visual-studio-code-y-docker)
- [🏁 Ejecutar un contenedor usando el Terminal de VS Code para un servidor web Apache](#-ejecutar-un-contenedor-usando-el-terminal-de-vs-code-para-un-servidor-web-apache) 
- [🏗️ Docker Hub web](#️-docker-hub-web) 
- [🖥️ Ejecutar un contenedor y lanzar un shell interactivo en él](#️-ejecutar-un-contenedor-y-lanzar-un-shell-interactivo-en-él) 
- [🌐 Mapear puerto de contenedor a los puertos de mi máquina local](#-mapear-puerto-de-contenedor-a-los-puertos-de-mi-máquina-local) 
- [🕹️ ¿Y si quiero ejecutar un contenedor en segundo plano?](#️-y-si-quiero-ejecutar-un-contenedor-en-segundo-plano)
- [🔄 Políticas de reinicio (--restart)](#-políticas-de-reinicio---restart)
- [🗑️ Limpiar automáticamente el contenedor (--rm)](#️-limpiar-automáticamente-el-contenedor---rm)
- [📋 Listar todos los contenedores que tengo en ejecución](#-listar-todos-los-contenedores-que-tengo-en-ejecución) 
- [🏷️ Bautizar contenedores](#️-bautizar-contenedores)
- [💾 Limitar recursos: CPU y Memoria](#-limitar-recursos-cpu-y-memoria)
- [🔄 ¿Cómo ejecutar comandos en un contenedor ya en ejecución?](#-cómo-ejecutar-comandos-en-un-contenedor-ya-en-ejecución)
- [🛠️ Ejecutar comandos desde mi local dentro del contenedor](#️-ejecutar-comandos-desde-mi-local-dentro-del-contenedor) 
- [🛑 ¿Cómo paro un contenedor?](#-cómo-paro-un-contenedor) 
- [🗑️ ¿Y si quiero eliminarlo del todo de mi ordenador?](#️-y-si-quiero-eliminarlo-del-todo-de-mi-ordenador)
- [Comandos Docker más comunes](#-comandos-docker-más-comunes) 
- [🗄️ SQL Server dockerizado](#️-sql-server-dockerizado)
- [ℹ️ Información del sistema Docker](#️-información-del-sistema-docker) 
- [✨ Gordon AI](#-gordon-ai) 
- [✨ GitHub Copilot](#-github-copilot)
- [🎉 ¡Felicidades!](#-felicidades)



## 🧰 Cómo instalar Docker en tu máquina local 🍋📺

A día de hoy, la forma más sencilla de instalar Docker en tu máquina local es a través de **Docker Desktop**, el cual está disponible tanto para Windows, como para Linux y Mac. Descarga el instalable que necesites para tu sistema operativo [desde la página oficial](https://www.docker.com/).

En los vídeos de la introducción podrás ver:

🐳🍎 [Cómo instalar Docker Desktop en MacOS](https://campus.lemoncode.net/#/training/68c9403afd3dcd0a256a0291/video-player/https%3A%2F%2Fd2gr4gsp182xcm.cloudfront.net%2Fcampus%2Fbootcamp-devops-vi%2Fintroduccion-modulo-2-contenedores%2F01-contenedores-i-demo-1-instalar-docker-desktop-macos.mp4).

🐳🪟 [Cómo instalar Docker Desktop en Windows](https://campus.lemoncode.net/#/training/68c9403afd3dcd0a256a0291/video-player/https%3A%2F%2Fd2gr4gsp182xcm.cloudfront.net%2Fcampus%2Fbootcamp-devops-vi%2Fintroduccion-modulo-2-contenedores%2F02-contenedores-i-demo-2-instalar-docker-desktop-windows.mp4).

 Una vez instalado, ¡ya estamos listos para empezar a jugar! ✨

## 👀 Conociendo Docker desde Docker Desktop 🍋📺

Cuando hayas instalado Docker Desktop verás que puedes empezar de forma muy visual, aunque es posible que al principio no tengas muy claro qué es lo que tienes que hacer 😅. Aunque es recomendable dominar la línea de comandos, ya que es la forma más rápida y común de trabajar con Docker en la vida real, vamos a empezar por lo sencillo para luego ir avanzando cada vez un poco más y que te vayas sintiendo cómod@ con los diferentes conceptos.

En el vídeo [Mi primer contenedor con Docker Desktop](https://campus.lemoncode.net/#/training/68c9403afd3dcd0a256a0291/video-player/https%3A%2F%2Fd2gr4gsp182xcm.cloudfront.net%2Fcampus%2Fbootcamp-devops-vi%2Fintroduccion-modulo-2-contenedores%2F03-contenedores-i-demo-3-mi-primer-contenedor-docker-desktop.mp4) 🍋📺 podrás ver todo esto explicado paso a paso.

### 📦 Mi primer contenedor con un servidor web 🍋📺

Ahora que ya tenemos instalado todo lo que necesitamos para empezar, nuestra primera misión va a ser, lógicamente, pues crear nuestro primer contenedor 📦, como no podía ser de otra manera 😅 Y para este primer ejemplo vamos a crear un contenedor que dentro tenga un servidor web, en este caso usando [Nginx](https://nginx.org/), aunque podría ser cualquier otro, como también veremos.

Ahora mismo en nuestra instalación de Docker Desktop no tenemos absolutamente nada, así que vamos a ver paso a paso cómo podemos crear este contenedor desde aquí.

Lo primero que necesitas es saber la imagen que podemos utilizar para tener un contenedor con Nginx ¿Y cómo puedo saber esto? Pues para ello tenemos que ir la sección llamada **Docker Hub** dentro de Docker Desktop:

![Docker Hub en Docker Desktop](imagenes/Docker%20Hub%20en%20Docker%20Desktop.png)

Aquí vas a poder ver que tenemos un buscador donde podemos investigar qué imágenes hay disponibles, listas para usar. Por lo que si busco por `nginx` seré capaz de encontrar lo que busco.

![nginx Docker Hub en Docker Desktop](imagenes/Nginx_en%20Docker%20Hub.png)

Si hago clic sobre la misma...

![Información sobre la imagen de Nginx](imagenes/Información%20sobre%20la%20imagen%20de%20nginx.png)

Podrás ver información relacionada con la imagen, como por ejemplo las etiquetas disponibles, la descripción de la misma, etc. Ya entraremos más en detalle en todo esto, pero por ahora lo que nos interesa es ejecutar un contenedor que utilice la misma, así que vamos a ejecutar el botón **Run** que aparece en la parte superior derecha de la pantalla.

Al hacerlo ocurriran dos cosas:

1. En la parte inferior dice que está haciendo pull de la imagen, es decir, descargándola 📥 a tu máquina local.
2. Te aparecerá un dialogo donde te pide un par de valores y la opción de ejecutar el contenedor.

![Ejecutar contenedor de Nginx](imagenes/Ejecutar%20un%20nuevo%20contenedor%20desde%20Docker%20Desktop.png)

Como por ahora no tenemos mucha idea, vamos a hacer clic directamente sobre el botón **Run** y veremos qué ocurre. Si todo ha ido bien, deberías ver en la sección de **Containers** que ya tienes un contenedor en ejecución 🚀

Cuando tienes un contenedor en ejecución verás que esté se está ejecutando porque tiene un circulo verde al lado del nombre. Pero como puedes ver, también se pueden parar, e incluso eliminar, contenedores. Además si hacemos clic sobre los tres puntos que aparecen al lado del nombre del contenedor, veremos que podemos acceder a más opciones, como por ejemplo ver los logs del contenedor, abrir una terminal dentro del mismo, etc. Y más recientemente también puedes ver que aparecen unas estrellitas ✨ al lado del botón de parada, que es el acceso rápido a **Gordon** el asistente IA de Docker que te ayudará a resolver dudas y problemas comunes. Lo veremos también con cariño más adelante para que puedas sacarle también partido y te ayude a aprender más sobre Docker.

>[!IMPORTANT]
>Es muy importante que tengas en cuenta que una imagen no es un contenedor. Es decir, que yo podría repetir este proceso varias veces y crear varios contenedores a partir de la misma imagen, cada uno con su propia configuración, estado, etc. Por ejemplo, si vuelves a hacer clic en el botón **Run** verás que te aparece un nuevo diálogo donde puedes configurar el nombre del contenedor, los puertos que quieres mapear, etc. Podríamos decir que una imagen es como una plantilla, y un contenedor es una instancia de esa plantilla.


Vale, ya tengo uno o varios contenedores con nginx, pero si ahora accedo a http://localhost no tengo ningun servidor web funcionando, ¿por qué? pues porque estos contenedores viven en un entorno aislado, y para poder acceder a ellos desde mi máquina local tengo que mapear los puertos del contenedor a los de mi máquina. Esto lo veremos más adelante, pero por ahora vamos a ver cómo podemos hacer esto desde la interfaz gráfica de Docker Desktop.

Si ahora vuelvo a crear un nuevo contenedor y hago clic en el botón **Run** de nuevo, verás que en el diálogo que aparece un cuadro de texto donde puedo proporcionar un puerto.

![Crear un contenedor indicando un puerto de mapeo](imagenes/Crear%20un%20contenedor%20indicando%20un%20puerto%20de%20mapeo.png)

A lo que se refiere es a un puerto de mi máquina local que esté libre por el cual yo quiera/pueda acceder a este nuevo contenedor que voy a crear. En mi ejemplo he usado el puerto 8080 pero podría ser cualquier otro por encima de 1024, ya que los puertos por debajo de este número suelen estar reservados para servicios del sistema operativo.

Al ejecutar el comando **Run** verás que en la sección de **Containers** aparece un nuevo contenedor pero este es diferente al resto, ya que tiene un enlace a un puerto de tu máquina local, en este caso el 8080. 

![Crear un contenedor indicando un puerto de mapeo](imagenes/Containers%20-%20contenedor%20con%20puerto%20mapeado.png)

Si haces clic sobre el enlace podrás acceder al servidor web que has creado con Nginx.

![Acceso al servidor web de Nginx](imagenes/En%20localhost%208080%20Welcome%20to%20Nginx.png)


¡🎉 Enhorabuena! Has creado tu primer contenedor con un servidor web Nginx. Pero esto es solo el principio. A medida que avancemos, aprenderás a personalizar y gestionar tus contenedores de manera más efectiva.

Y ahora que ya lo has visto todo desde la interfaz gráfica de Docker Desktop, vamos a ver cómo podemos hacer lo mismo pero desde la línea de comandos, que es la forma más común de trabajar con Docker en la vida real. Para ello, abre el terminal integrado de Docker Desktop haciendo clic en el icono de la terminal en la parte superior derecha de la ventana:

![Terminal integrado en Docker Desktop](imagenes/Terminal%20integrado%20en%20Docker%20Desktop.png)

## 🐳 Docker CLI 🍋📺

Docker CLI (Command Line Interface) es la herramienta que te permite interactuar con Docker desde la línea de comandos. Aunque Docker Desktop ofrece una interfaz gráfica, es recomendable familiarizarse con el CLI para aprovechar al máximo las capacidades de Docker. 

Para hacer lo mismo que hicimos antes desde la interfaz gráfica, vamos a usar el comando `docker run` para crear un contenedor con Nginx. Abre el terminal integrado de Docker Desktop y ejecuta el siguiente comando:

```bash
docker run nginx
```

Este comando descargará la imagen de Nginx (si no la tienes ya) y creará un contenedor a partir de ella. Sin embargo, a este nuevo contenedor le ocurrirá lo mismo que a los que creamos inicialmente y es que no podremos acceder a él desde nuestro navegador, ya que no hemos mapeado ningún puerto. Así que vamos a hacer lo mismo que hicimos antes pero ahora desde la línea de comandos.

Para mapear el puerto del contenedor al de tu máquina local, usa el siguiente comando:

```bash
docker run --publish 8080:80 nginx
```

Por otro lado, en estos dos casos te darás cuenta de que el terminal queda "bloqueado" y no puedes hacer nada más hasta que pares el contenedor. Esto es porque Nginx es un servidor web que necesita estar activo para poder responder a las peticiones. Si quieres ejecutar el contenedor en segundo plano, puedes usar la opción `-d` o `--detach`:

```bash
docker run --detach --publish 8080:80 nginx
```

Y hasta aquí la parte introductoria que pudiste ver en los vídeos del campus. A partir de aquí, vamos a seguir viendo más comandos y opciones que te permitirán gestionar tus contenedores de manera más efectiva.

## Visual Studio Code y Docker

Ahora que tienes Docker Desktop instalado, puedes integrarlo con Visual Studio Code para una experiencia aún más fluida. Asegúrate de tener instalada [la extensión Container Tools](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-containers). Esto te permitirá gestionar contenedores, imágenes y redes directamente desde el editor. Además, como tienes instalado Docker CLI, podrás ejecutar comandos de Docker desde el terminal integrado de VS Code.

A partir de este momento, usaremos este editor para todas nuestras prácticas, ya que es gratuito, multiplataforma y muy popular entre los desarrolladores. Si no lo tienes instalado, descárgalo desde [su página oficial](https://code.visualstudio.com/).

## 🏁 Ejecutar un contenedor usando el Terminal de VS Code para un servidor web Apache

```bash
docker run httpd
```

`httpd` es la imagen oficial de Apache HTTP Server que usas para crear tu contenedor. De esta forma creas un contenedor con un servidor web Apache, que es una alternativa muy popular a Nginx.

Para ver las imágenes descargadas en tu local:

```bash
docker image ls
```

O bien:

```bash
docker images
```

También puedes ver las imágenes a través de la extensión de VS Code, en el apartado Images. Y si seleccionas cualquiera de ellas podrás ver las acciones que puedes hacer con las mismas.

## 🏗️ Docker Hub web

Todas las imágenes por defecto de Docker vienen de [Docker Hub](https://hub.docker.com/), un repositorio de imágenes que puedes usar en tus proyectos. Puedes buscar imágenes en Docker Hub desde la interfaz gráfica de Docker Desktop o desde el CLI. Por ejemplo, para buscar un servidor web como Apache:

```bash
docker search httpd
```

O si quisiéramos buscar Nginx:

```bash
docker search nginx
```


Por supuesto hay otro tipo de imágenes como de Sistemas Operativos, Bases de Datos, etc. Puedes buscar lo que necesites y ver las imágenes disponibles. Si por ejemplo quisieramos un contenedor con Ubuntu, podríamos buscarlo así:

```bash
docker search ubuntu
```

Y ejecutar un contenedor con Ubuntu:

```bash
docker run ubuntu
```

Pero... ¿Qué ha pasado? pues que en este caso, que es un poquito diferente al de los servidores web, al ejecutar el comando `docker run ubuntu` no hemos especificado ningún comando a ejecutar dentro del contenedor, por lo que este se ha cerrado inmediatamente. 

## 🖥️ Ejecutar un contenedor y lanzar un shell interactivo en él

Para evitar esto, podemos ejecutar un shell interactivo dentro del contenedor:

```bash
docker run --interactive --tty ubuntu /bin/bash
```

O la versión abreviada que es más común:

```bash
docker run -it ubuntu /bin/bash
```

Para comprobar que estás dentro del contenedor, puedes ejecutar:

```bash
cat /etc/os-release
exit
```

### 🔑 Entendiendo el parámetro `-it`

El parámetro `-it` es en realidad la **combinación de dos flags diferentes** que funcionan juntos:

- **`-i` (o `--interactive`)**: Mantiene STDIN abierto incluso sin estar conectado. Esto permite que el contenedor reciba entrada desde tu teclado.
- **`-t` (o `--tty`)**: Asigna una pseudo-terminal (TTY) al contenedor. Esto proporciona una interfaz interactiva con salida formateada.

**📊 Matriz de comportamientos:**

| Flags | Comportamiento | Caso de uso |
|-------|----------------|-----------|
| Sin `-i` ni `-t` | El contenedor se cierra inmediatamente | Comandos que terminan rápidamente |
| Solo `-i` | Puedes escribir, pero no ves la salida bien formateada | Poco común |
| Solo `-t` | Ves la salida, pero no puedes escribir | Ver logs sin interactuar |
| **`-it`** | ✅ **Modo interactivo completo**: escribes y ves la salida formateada | **Usar para shells, debugging, exploración** |

**💡 Analogía:**
Piénsalo como una videollamada:
- `-i` = Micrófono activado (puedes hablar)
- `-t` = Cámara activada (puedes ver)
- `-it` = Videollamada completa (puedes hablar Y ver)

**🎯 Casos de uso de `-it`:**

```bash
# Explorar dentro de un contenedor
docker run -it ubuntu /bin/bash

# Ejecutar un comando interactivo (como un editor)
docker run -it alpine vi /archivo.txt

# Debugging en un contenedor en ejecución
docker exec -it my-container bash

# Ejecutar Python interactivamente
docker run -it python python

# Conectarse a una base de datos
docker exec -it mi-mysql mysql -u root -p
```

**⚠️ Importante:**
- `-it` solo funciona con **comandos que esperan entrada/salida interactiva** (bash, sh, python, mysql, etc.)
- No uses `-it` con comandos que se ejecutan en background o servicios de larga duración (usa `-d` en su lugar)
- Si usas `-it` con `-d` (detach), Docker ignorará el `-it` porque `-d` lo anula

**Comparación práctica:**

```bash
# ❌ MAL: El contenedor termina porque bash se cierra al no tener entrada
docker run ubuntu /bin/bash

# ❌ MAL: Bash se ejecuta en background, no puedes interactuar
docker run -d ubuntu /bin/bash

# ✅ BIEN: Obtienes una shell interactiva
docker run -it ubuntu /bin/bash

# ✅ BIEN: Accedes a un contenedor ya en ejecución
docker exec -it nombre-contenedor bash
```

## 🌐 Mapear puerto de contenedor a los puertos de mi máquina local

Para acceder a un contenedor desde tu máquina local necesitas mapear el puerto del contenedor al de tu máquina. Por ejemplo, para acceder a Apache mapea el puerto 80 del contenedor al 8080 de tu máquina:

```bash
docker run --publish 8081:80 httpd
```

O bien:

```bash
docker run -p 8081:80 httpd
```

Ahora si accedes a [http://localhost:8081](http://localhost:8081) verás el servidor web de Apache. 🌍

## 🕹️ ¿Y si quiero ejecutar un contenedor en segundo plano?

Puedes ejecutar un contenedor en segundo plano usando la opción `-d` o `--detach`:

```bash
docker run --detach -p 8080:80 httpd
```

O bien:

```bash
docker run -d -p 8080:80 httpd
```

## 🔄 Políticas de reinicio (--restart)

Controlan qué hace Docker cuando el contenedor se detiene:

```bash
--restart=no              # No reiniciar nunca (por defecto)
--restart=always          # Reiniciar siempre
--restart=unless-stopped  # Reiniciar a menos que se pare manualmente
--restart=on-failure      # Solo reiniciar si falla
--restart=on-failure:3    # Reiniciar máximo 3 veces si falla
```

**💡 Recomendación**: Usar `unless-stopped` para servicios que quieres que arranquen con el sistema pero puedas parar manualmente.

Ejemplo de uso:

```bash
docker run -d --restart=unless-stopped -p 8080:80 httpd
```

## 🗑️ Limpiar automáticamente el contenedor (--rm)

La opción `--rm` elimina automáticamente el contenedor cuando se detiene. Es muy útil para no dejar contenedores "basura" acumulándose en tu sistema.

```bash
docker run --rm -p 8080:80 httpd
```

O combinado con otras opciones:

```bash
docker run -d --rm --name web -p 8080:80 httpd
```

**📊 Comparación de comportamientos:**

| Comando | Qué sucede al parar el contenedor |
|---------|----------------------------------|
| `docker run httpd` | El contenedor queda **parado pero guardado** en el sistema. Ocupa espacio. |
| `docker run --rm httpd` | El contenedor se **elimina automáticamente**. No deja rastro. |

**🎯 Casos de uso:**

- **Usa `--rm`**: Para experimentar, probar, debugging, contenedores temporales
- **No uses `--rm`**: Para servicios que quieres mantener (bases de datos, servidores en producción)

**💡 Ejemplos prácticos:**

```bash
# Probar una imagen rápidamente (con --rm para no dejar basura)
docker run --rm ubuntu echo "¡Hola desde Ubuntu!"

# Ejecutar un script de prueba (desaparece automáticamente)
docker run --rm -v $(pwd):/app mi-app:latest /app/test.sh

# Servidor temporal de prueba (se limpia al parar)
docker run -d --rm --name temp-server -p 9090:80 nginx

# Acceder a un shell interactivo y limpiarse automáticamente
docker run --rm -it ubuntu /bin/bash
```

**⚠️ Importante**: Si usas `--rm` con `-d` (detach), el contenedor se eliminará tan pronto se detenga, incluso si hay errores. Asegúrate de tener logs configurados si lo necesitas.

## 📋 Listar todos los contenedores que tengo en ejecución

Para ver los contenedores en ejecución:

```bash
docker ps
```

Para ver todos los contenedores (incluidos los parados):

```bash
docker ps --all
```

O bien:

```bash
docker ps -a
```

## 🏷️ Bautizar contenedores

Docker asigna nombres aleatorios a los contenedores, pero puedes elegir el nombre que quieras con la opción `--name`:

```bash
docker run -d --name web -p 9090:80 httpd
```

Para ver el nuevo contenedor llamado `web`:

```bash
docker ps
```

También puedes renombrar contenedores existentes:

```bash
docker rename NOMBRE_ASIGNADO_POR_DOCKER hello-world
docker ps -a
```

## �🔄 ¿Cómo ejecutar comandos en un contenedor ya en ejecución?

Puedes conectarte a un contenedor en ejecución desde Docker Desktop o desde el CLI. Por ejemplo:

```bash
docker run --name webserver -d httpd 
```

Y luego:

```bash
docker exec -it webserver bash # Ejecuto bash dentro del contenedor y con -it me atacho a él
cat /etc/apache2/apache2.conf
exit
```

## 🛠️ Ejecutar comandos desde mi local dentro del contenedor

Puedes usar el subcomando `exec` para ejecutar comandos dentro del contenedor. Por ejemplo, para ver los archivos de log de Apache:

```bash
docker exec web ls /var/log/apache2
```

## 🛑 ¿Cómo paro un contenedor?

Para parar un contenedor:

```bash
docker stop web
```

Para volver a arrancarlo:

```bash
docker start web
```

## 🗑️ ¿Y si quiero eliminarlo del todo de mi ordenador?

Asegúrate de que el contenedor está parado:

```bash
docker stop web
```

Y elimínalo:

```bash
docker rm web
```

Comprueba que ya no aparece:

```bash
docker ps -a
```

También puedes hacerlo desde la interfaz gráfica de Docker Desktop.

## 📚 Comandos Docker más comunes

Ahora que ya has aprendido los conceptos básicos, aquí tienes un resumen de los comandos Docker más utilizados en el día a día:

### 🏃 Ejecutar contenedores
```bash
docker run httpd                    # Ejecutar un contenedor
docker run -d httpd                 # Ejecutar en segundo plano
docker run -p 8080:80 httpd         # Mapear puertos
docker run --name mi-apache httpd   # Asignar nombre personalizado
```

### 📋 Listar y gestionar contenedores
```bash
docker ps                          # Ver contenedores en ejecución
docker ps -a                       # Ver todos los contenedores
docker stop mi-apache               # Parar un contenedor
docker start mi-apache              # Iniciar un contenedor parado
docker restart mi-apache            # Reiniciar un contenedor
```

### 🔧 Ejecutar comandos en contenedores
```bash
docker exec -it mi-apache bash     # Abrir terminal interactiva
docker exec mi-apache ls /var/www  # Ejecutar comando específico
```

### 🖼️ Gestionar imágenes
```bash
docker images                      # Listar imágenes locales
docker search apache               # Buscar imágenes en Docker Hub
```

### ℹ️ Información del sistema
```bash
docker version                     # Ver versión de Docker
docker info                        # Información del sistema Docker
```

### 🗑️ Limpiar recursos
```bash
docker rm mi-apache                # Eliminar contenedor
docker rm $(docker ps -aq)         # Eliminar todos los contenedores parados
```

### ⚡ Comandos combinados para limpiar rápido

Para parar y eliminar todos los contenedores:

```bash
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
```

## 🗄️ SQL Server dockerizado

Vamos a ver cómo usar Docker para tener un SQL Server en tu máquina local. Por ejemplo, para desarrollo, puedes usar la imagen oficial de Microsoft:

```bash
docker run --name mysqlserver \
-p 1433:1433 \
-e 'ACCEPT_EULA=Y' \
-e 'SA_PASSWORD=Lem0nCode!' \
-d mcr.microsoft.com/mssql/server:2019-latest
```

- `docker run`: lanza un contenedor.
- `--name db`: nombre del contenedor.
- `-p 1433:1433`: mapea el puerto.
- `-e 'ACCEPT_EULA=Y'`: acepta la licencia.
- `-e 'SA_PASSWORD=Lem0nCode!'`: contraseña del usuario `sa`.
- `-d mcr.microsoft.com/mssql/server:2019-latest`: imagen a usar.

Conéctate al contenedor:

```bash
docker exec -it mysqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Lem0nCode! 
```

Crea una base de datos y una tabla:

```sql
CREATE DATABASE Lemoncode;
GO
USE Lemoncode;
GO
CREATE TABLE Courses(ID int, Name varchar(max), Fecha DATE);
GO
SET LANGUAGE ENGLISH;
GO
INSERT INTO Courses VALUES (1, 'Bootcamp DevOps', '2024-10-8'), (2,'Máster Frontend','2024-10-08');
GO
```

Conéctate con Visual Studio Code, [con la extensión MSSQL](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql), a tu `localhost:1433` y tendrás acceso a tu SQL Server dockerizado! 🗃️

Cuando termines, para y elimina tu SQL Server dockerizado:

```bash
exit
docker stop mysqlserver && docker rm mysqlserver
```

O bien, todo de golpe:

```bash
docker rm -f mysqlserver
```

## ℹ️ Información del sistema Docker

Para obtener información detallada sobre tu instalación de Docker, puedes usar estos comandos útiles:

```bash
docker version                     # Ver versión de Docker
docker info                        # Información detallada del sistema Docker
```

El comando `docker version` te mostrará las versiones del cliente y servidor Docker, mientras que `docker info` te dará información completa sobre el estado del sistema, incluyendo número de contenedores, imágenes, configuración de red, y más.

## ✨ Gordon AI

Ahora que ya te he contado todo lo que deberías de saber en el día 1 de tu inicio en el mundo de los contenedores, no puedo evitar mecionar que a partir de ahora vas a tener una ayuda adicional en la que te vas a poder apoyar dudante este camino. Y es que como parte de Docker tienes a tu disposición un asistente IA llamado **Gordon** que te ayudará a resolver dudas y problemas comunes. Puedes acceder a él desde Docker Desktop haciendo clic en la sección **✨ Ask Gordon** en el menú de la izquierda. 


Donde podrás ver un chat y un historico de las conversaciones que has tenido con él, de tal forma que puedas retomarlas en cualquier momento.

Además, también es posible hablar con él a través del terminal, por si no estás usando directamente Docker Desktop. Para ello puedes lanzar un comando como el siguiente:


```bash
docker ai "How can I run a container with Nginx?"
```

El único inconveniente a día de hoy es que Gordon solo está disponible en inglés, por lo que tendrás que hacer las preguntas en este idioma. Si intento lo mismo en español:

```bash
docker ai "¿Cómo puedo ejecutar un contenedor con Nginx?"
```

A veces funciona, pero en otras ocasiones no. Así que te recomiendo que uses el inglés para interactuar con él.

## ✨ GitHub Copilot

Si estás usando Visual Studio Code, también puedes aprovechar [GitHub Copilot](https://github.com/features/copilot) para obtener sugerencias de código y completar automáticamente tus comandos de Docker. Este tiene un plan gratuito que te permite usarlo con ciertas limitaciones. También dispone de un chat donde puedes hacerle preguntas y te ayudará a resolver dudas sobre Docker y otros temas relacionados con el desarrollo.

Lo ideal es que aprendas los conceptos básicos de Docker y que puedas apoyarte en estos agentes, te ayuden a resolver dudas y te den sugerencias de código, pero no que dependas de ellos para todo. Así que te animo a que practiques y experimentes con Docker por tu cuenta, y uses estas herramientas como apoyo cuando lo necesites.

---

## 🎉 ¡Felicidades!

En esta primera clase has aprendido a:

- 🖥️ Instalar Docker Desktop en tu máquina local.
- 👀 Conocer Docker desde Docker Desktop.
- 🚀 Crear tu primer contenedor con un servidor web (Nginx).
- 🐳 Trabajar con Docker CLI desde la línea de comandos.
- 🔧 Integrar Visual Studio Code con Docker.
- 🏁 Ejecutar contenedores Apache usando el Terminal de VS Code.
- 📦 Ver las imágenes descargadas en tu local.
- 🔍 Buscar imágenes en Docker Hub.
- 🖥️ Ejecutar un contenedor y lanzar un shell interactivo en él.
- 🌐 Mapear puertos de contenedor a tu máquina local.
- 🕹️ Ejecutar un contenedor en segundo plano.
- 📋 Listar todos los contenedores en ejecución.
- 🏷️ Bautizar contenedores con nombres personalizados.
- 🔄 Ejecutar comandos en un contenedor ya en ejecución.
- 🛠️ Ejecutar comandos desde tu local dentro del contenedor.
- 🛑 Parar y reiniciar contenedores.
- 🗑️ Eliminar contenedores del todo de tu ordenador.
- 📚 Dominar los comandos Docker más comunes del día a día.
- 🗄️ Crear y gestionar un SQL Server dockerizado.
- ℹ️ Obtener información del sistema Docker.
- ✨ Conocer Gordon AI, el asistente de Docker.
- ✨ Usar GitHub Copilot como apoyo en el desarrollo.

En la siguiente clase veremos cómo crear nuestras propias imágenes de Docker.

Happy coding {🍋}
