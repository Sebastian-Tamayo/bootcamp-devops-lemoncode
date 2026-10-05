# Día VI: Docker Compose y Docker Swarm 🚀

![Docker Compose](imagenes/Docker%20compose.png)

¡Hola lemoncoder 👋🏻🍋 ! Con esta clase finalizamos el repaso a los contenedores. Y ha llegado el momento de aprender qué es Docker Compose y nuestra primera expidición a los clústeres de Docker.

## 🎬 Vídeos de la introducción en el campus

Se asume que has visto los siguientes vídeos para comenzar con este módulo:

| # | Tema | Contenido Clave |
|---|------|-----------------|
| 1 | Teoría - Docker Compose | El por qué y para qué de Docker Compose |
| 2 | Demo 1 | Ejemplo sin Docker Compose |
| 3 | Demo 2 - Ejemplo de un Wordpress con Docker Compose |
| 4 | Teoría - Docker Swarm | Para qué sirve un clúster y cómo se gestiona |
| 5 | Demo 3 - Crear un clúster con Docker Swarm | Crear un cluster y ejecutar nuestra primera aplicación |

---


## 🏗️ Introducción a Docker Compose

Docker Compose es una herramienta que te permite definir y ejecutar aplicaciones Docker multi-contenedor. En lugar de ejecutar múltiples comandos `docker run`, `docker volume`, `docker network`, etc., puedes definir toda tu aplicación en un archivo YAML y levantarla con un solo comando.

### 🎯 Escenario: Blog con WordPress y MySQL

Para que lo entiendas perfectamente, imaginemos que queremos desplegar un blog con WordPress. Este necesita una base de datos MySQL para funcionar. Con todo lo que hemos aprendido hasta ahora, vamos a ver primero cómo hacerlo manualmente y luego con Docker Compose.

### 📝 Manual vs Docker Compose

**Método manual (el camino difícil 😅):**

Primero, navega al directorio de trabajo:

```bash
cd 01-contenedores/contenedores-vi
```

**1. Crear la red donde ambos contenedores van a comunicarse:**

```bash
docker network create wordpress-network
```

**2. Crear la base de datos MySQL:**

```bash
docker run -dit --name mysqldb \
--network wordpress-network \
--mount source=mysql_data,target=/var/lib/mysql \
 -e MYSQL_ROOT_PASSWORD=somewordpress \
 -e MYSQL_DATABASE=wpdb \
 -e MYSQL_USER=wp_user \
 -e MYSQL_PASSWORD=wp_pwd \
  mysql:8.0
```

Verifica que se ha creado el volumen:

```bash
docker volume ls
```

**3. Crear el contenedor de WordPress:**

```bash
docker run -dit --name wordpress \
--network wordpress-network \
-v wordpress_data:/var/www/html \
-e WORDPRESS_DB_HOST=mysqldb:3306 \
-e WORDPRESS_DB_USER=wp_user \
-e WORDPRESS_DB_PASSWORD=wp_pwd \
-e WORDPRESS_DB_NAME=wpdb \
-p 8000:80 wordpress:6.6.2-php8.1-apache
```

Puedes verificar el contenido del volumen de WordPress:

```bash
docker exec wordpress ls -l /var/www/html
```

Y ahora si accedes a `http://localhost:8000` en tu navegador, deberías ver la pantalla de instalación de WordPress.


**Para limpiar todo este despliegue manual:**

```bash
docker kill wordpress mysqldb && \
  docker rm wordpress mysqldb && \
  docker network rm wordpress-network && \
  docker volume rm mysql_data wordpress_data
```

Como puedes ver, ¡son muchos comandos para una aplicación simple! 😰

## 🐳 Docker Compose en acción

Ahora veamos cómo Docker Compose simplifica todo esto. Primero, echemos un vistazo al archivo de configuración:

```bash
cat compose.yml
```

Este archivo define toda nuestra aplicación en un formato legible y mantenible.

### ⚡ Comandos básicos de Compose

**Levantar la aplicación:**

```bash
docker compose up
```

**💡 Truco:** Si quieres seguir usando la terminal mientras ves la salida:

```bash
docker compose up &
```

**Ejecutar en segundo plano:**

```bash
docker compose up -d
```

Cuando la tienes abierta descubrirás que en la parte inferior del terminal te propone tres comandos rápidos: 

- `v` View in Docker Desktop: si pulsas esta tecla te lleva directamente a una vista donde verás los contenedores involucrados.


![View in Docker Desktop](imagenes/Docker%20Compose%20-%20View%20in%20Docker%20Desktop.png)

- `o` View Config: si pulsas esta tecla te lleva de nuevo a Docker Desktop pero esta vez a una vista donde verás el archivo Docker Compose y opciones adicionales para entenderlo e incluso para convertirlo a los archivos que un clúster de Kubernetes necesita.

![View Config](imagenes/Docker%20Compose%20-%20View%20Config.png)

- `watch` Enable Watch: si pulsas esta tecla se activa la funcionalidad de Compose Watch que veremos más adelante en este mismo documento y que es ideal para desarrollo.

**Parar la aplicación:**

Si quisieramos parar todos los contenedores, podríamos usar `Control + C` o `Cmd + C` si lo hemos levantado en primer plano, pero si lo hemos hecho en segundo plano:


```bash
docker compose stop
```

**Parar y eliminar todo:**

```bash
docker compose down
```

Hurra! 🎉 Has desplegado una aplicación completa con solo unos pocos comandos y un archivo súper descriptivo que te ayuda a entender perfectamente qué necesita tu aplicación.

Ahora vamos a ver algunas funcionalidades avanzadas de Docker Compose.

### Configuraciones avanzadas de Docker Compose

Para esta sección vamos a usar otro ejemplo más complejo que puedes encontrar en `01-contenedores/contenedores-vi/my-app`, el cual contiene un frontend y un backend. Para levantarlo con docker compose, navega a esa carpeta y ejecuta:

```bash
cd 01-contenedores/contenedores-vi/my-app
docker compose up
```

### Docker Compose Watch

Docker Compose Watch permite que los servicios se actualicen automáticamente cuando editas archivos en tu proyecto. Es ideal para desarrollo, ya que puedes ver los cambios reflejados en los contenedores sin reiniciar manualmente.

### 🔭 Ventajas de Docker Compose Watch

- 🔁 Sincronización automática de archivos entre tu máquina y el contenedor.
- 🚫 Posibilidad de ignorar carpetas (ej. node_modules/) para mejorar rendimiento.
- 🛠 Acciones soportadas: sync (sincronizar), rebuild (reconstruir imagen) y sync+restart (sincronizar y reiniciar servicio).

### ⚙️ Configuración básica

Añade la sección develop.watch en el servicio que quieres monitorizar dentro del archivo compose.watch.yml.

```yaml
services:
  app:
    build: .
    develop:
      watch:
        - action: sync
          path: ./src
          target: /app/src
        - action: rebuild
          path: package.json
        - action: sync+restart
          path: ./config
```

### 🧪 Acciones

- sync: Copia al contenedor solo los archivos modificados.
- rebuild: Reconstruye la imagen si cambia un archivo clave (ej. package.json).
- sync+restart: Sincroniza y reinicia el servicio (útil para cambios de configuración).

Con el mismo entorno que tenemos si ahora pulsas la tecla `w` en la terminal donde tienes levantado el docker compose, se activará el modo watch y podrás ver los cambios reflejados automáticamente cuando los hagas en tu código fuente.


### Perfiles en Docker Compose

Los perfiles en Docker Compose permiten definir diferentes configuraciones para un mismo servicio, facilitando la gestión de entornos de desarrollo, pruebas y producción. Puedes activar un perfil específico al levantar los servicios.

### 🔧 Gestión avanzada de proyectos

Si quieres construir la imagen cada vez:

```bash
docker compose up --build
```

**Ver contenedores del proyecto actual:**

```bash
docker compose ps
```

> **Nota:** Este comando solo muestra contenedores del proyecto en la carpeta actual.

**Ver todos los contenedores (como siempre):**


```bash
docker ps -a
```

**Listar todos los proyectos de Docker Compose en ejecución:**

```bash
docker ps -a --filter "label=com.docker.compose.project" -q | xargs docker inspect --format='{{index .Config.Labels "com.docker.compose.project"}}'| sort | uniq
```

**Asignar un nombre personalizado al proyecto:**

```bash
docker compose --project-name my_wordpress up -d
```

**Reiniciar aplicación con nombre específico:**

```bash
docker compose -p my_wordpress restart
```

**Limpiar proyecto específico:**

```bash
docker compose -p my_wordpress down
```

## Dev Containers con Docker Compose

Docker Compose también se puede utilizar para definir entornos de desarrollo en contenedores (Dev Containers). Esto es especialmente útil para proyectos que requieren múltiples servicios o dependencias.

El propio repositorio de este bootcamp está configurado para usarse como un Dev Container usando Docker Compose. Si abres este proyecto en VS Code con la extensión de Dev Containers instalada, verás que se levanta un entorno completo con Node.js y todas las dependencias necesarias.

## 🌊 Introducción a Docker Swarm

![Docker Swarm](imagenes/Docker%20Swarm.png)

Docker Swarm es el orquestador nativo de Docker que te permite crear y gestionar un cluster de nodos Docker. Es perfecto para aplicaciones que necesitan alta disponibilidad y escalabilidad.

**Inicializar un cluster Swarm:**

```bash
docker swarm init
```

> **Nota:** En Windows y Mac, Docker usa virtualización, por lo que la IP que ves no será la de tu máquina local.

**Para salir del cluster:**

```bash
docker swarm leave --force
```

### 🎪 Creando un cluster Swarm

Para demostrar Docker Swarm en un entorno multi-nodo, puedes usar diferentes aproximaciones:

- **Múltiples máquinas físicas o virtuales** con Docker instalado
- **Servicios cloud** como AWS EC2, Azure VMs, Google Compute Engine
- **Herramientas de virtualización local** como VirtualBox o VMware

**Inicializar Swarm en el nodo principal:**

```bash
docker swarm init --advertise-addr <IP-DEL-NODO-PRINCIPAL>
```

**Ver nodos del cluster:**

```bash
docker node ls
```

**Obtener token para managers:**

```bash
docker swarm join-token manager
```

**Unir nodos adicionales como managers:**

```bash
# En cada nodo que quieras como manager
docker swarm join --token <MANAGER-TOKEN> <IP-PRINCIPAL>:2377
```

**Obtener token para workers:**

```bash
docker swarm join-token worker
```

**Unir workers al cluster:**

```bash
# En cada nodo worker
docker swarm join --token <WORKER-TOKEN> <IP-PRINCIPAL>:2377
```

**Verificar cluster completo:**

```bash
docker node ls
```

> El asterisco (*) indica desde qué nodo estás ejecutando el comando.

## 🚀 Desplegando servicios en Swarm

**Crear un servicio nginx con 5 réplicas:**

```bash
docker service create --name web-nginx \
   -p 8080:8080 \
   --replicas 5 \
   nginx
```

**Ver servicios desplegados:**

```bash
docker service ls
```

**Ver detalles de dónde están las réplicas:**

```bash
docker service ps web-nginx
```

**Información detallada del servicio:**

```bash
docker service inspect --pretty web-nginx
docker service inspect web-nginx  # Formato JSON
```

### 📊 Escalado y monitorización

**Escalar el servicio:**

```bash
docker service scale web-nginx=10
docker service ls
docker service ps web-nginx
```

**Crear servicio solo en workers:**

```bash
docker service create \
    --replicas 3 \
    --name nginx-workers-only \
    --constraint node.role==worker \
    nginx
```

**Verificar distribución:**

```bash
docker service ps nginx-workers-only
```

**Visualizador de Docker Swarm:**

```bash
docker service create \
  --name=docker-swarm-visualizer \
  --publish=9090:8080 \
  --constraint=node.role==manager \
  --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  dockersamples/visualizer
```

**Ver servicios y acceder al visualizador:**

```bash
docker service ls
docker service ps docker-swarm-visualizer

# Acceder desde cualquier nodo (gracias al modo Ingress)
# Ir a <IP-DE-CUALQUIER-NODO>:9090 en el navegador
```

### 🌐 Networking: Ingress vs Host

**Modo Ingress (por defecto):**
Cualquier nodo puede responder, aunque no tenga réplica:

```bash
docker service create --name my_web_ingress --replicas 2 --publish published=8090,target=80 nginx

# Verificar dónde están las réplicas
docker service ps my_web_ingress

# Acceder desde un nodo sin réplica (¡Funciona gracias al modo Ingress!)
curl <IP-NODO-SIN-REPLICA>:8090
```

**Modo Host:**
Solo responde el nodo que tiene la réplica:

```bash
docker service create --name my_web_host --replicas 2 --publish published=8070,target=80,mode=host nginx

# Verificar distribución
docker service ps my_web_host

# Intentar acceder desde nodo sin réplica
curl <IP-NODO-SIN-REPLICA>:8070  # No funciona

# Acceder desde nodo con réplica
curl <IP-NODO-CON-REPLICA>:8070  # ¡Funciona!
```

## 📦 Docker Stacks

Docker Stacks te permite usar archivos de Docker Compose en clusters Swarm.

**Navegar al directorio de ejemplo:**

```bash
cd 01-contenedores/contenedores-vi/stacks/stackdemo
```

**❌ Lo que NO debes hacer (Docker Compose en cluster):**

```bash
docker-compose up &  # Solo crea contenedores en el nodo actual
docker-compose ps    # Los ves aquí
docker service ls     # Pero NO como servicios de Swarm
```

**✅ Lo correcto (Docker Stack):**

```bash
docker stack deploy -c docker-compose.yml stackdemo
```

**Gestionar stacks:**

```bash
# Ver todos los stacks
docker stack ls

# Ver detalles del stack
docker stack ps stackdemo

# Ver servicios del stack
docker stack services stackdemo

# Verificar en la lista general de servicios
docker service ls

# Acceder a la aplicación
curl <IP-NODO>:30001
```

## 📚 Comandos Docker Compose más comunes

### 🚀 Gestión básica
```bash
docker compose up                    # Levantar aplicación
docker compose up -d                 # Ejecutar en segundo plano
docker compose up --build            # Construir imágenes y ejecutar
docker compose down                  # Parar y eliminar todo
docker compose stop                  # Solo parar contenedores
docker compose restart               # Reiniciar servicios
```

### 📋 Información y gestión
```bash
docker compose ps                    # Ver contenedores del proyecto
docker compose logs                  # Ver logs de todos los servicios
docker compose logs [servicio]      # Ver logs de un servicio específico
docker compose exec [servicio] bash # Ejecutar comando en servicio
```

### 🏷️ Gestión de proyectos
```bash
docker compose -p [nombre] up        # Usar nombre de proyecto personalizado
docker compose -p [nombre] down      # Limpiar proyecto específico
docker compose -f [archivo] up       # Usar archivo compose específico
```

## 📚 Comandos Docker Swarm más comunes

### 🎪 Gestión de cluster
```bash
docker swarm init                    # Inicializar cluster
docker swarm join [token]            # Unirse a cluster
docker swarm leave --force           # Salir del cluster
docker node ls                       # Listar nodos del cluster
docker swarm join-token manager      # Obtener token para managers
docker swarm join-token worker       # Obtener token para workers
```

### 🚀 Gestión de servicios
```bash
docker service create               # Crear servicio
docker service ls                   # Listar servicios
docker service ps [servicio]        # Ver réplicas del servicio
docker service inspect [servicio]   # Información detallada
docker service scale [servicio]=N   # Escalar servicio
docker service update [servicio]    # Actualizar servicio
docker service rm [servicio]        # Eliminar servicio
```

### 📦 Gestión de stacks
```bash
docker stack deploy -c [archivo] [nombre]  # Desplegar stack
docker stack ls                            # Listar stacks
docker stack ps [stack]                    # Ver servicios del stack
docker stack services [stack]              # Detalles de servicios
docker stack rm [stack]                    # Eliminar stack
```

---

## 🎉 ¡Felicidades!

En esta clase avanzada has dominado:

### 🏗️ Docker Compose
- 📝 **Gestión declarativa** de aplicaciones multi-contenedor
- ⚡ **Comandos esenciales** para desarrollo y producción
- 🔧 **Gestión de proyectos** con nombres personalizados
- 🏗️ **Construcción automática** de imágenes

### 🌊 Docker Swarm
- 🎪 **Creación de clusters** distribuidos
- 🚀 **Despliegue de servicios** distribuidos
- 📊 **Escalado dinámico** y gestión de réplicas
- 🌐 **Networking avanzado** (Ingress vs Host)
- 👁️ **Monitorización visual** con Swarm Visualizer

### 📦 Docker Stacks
- 🔄 **Reutilización** de archivos Docker Compose en clusters
- 🎯 **Despliegue coherente** en entornos distribuidos
- 📊 **Gestión centralizada** de aplicaciones complejas

Has pasado de gestionar contenedores individuales a orquestar aplicaciones completas en clusters distribuidos. ¡Esto es orquestación de contenedores de nivel profesional! 🎯

Y con esta clase has completado tu aprendizaje de Docker 🎉

Happy orchestrating! 🍋🚀
