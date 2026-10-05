# Módulo 01 - Contenedores Docker 📦🐳

¡Hola lemoncoder 🍋👩🏼‍💻🧑🏽‍💻! Bienvenid@ al módulo de contenedores Docker, donde aprenderás desde los conceptos básicos hasta técnicas avanzadas de contenerización y orquestación con Docker Compose y Docker Swarm.

## 📋 Índice del Contenido

### 📁 Estructura del Directorio

- **[contenedores-i/](./contenedores-i/)** - Día I: Introducción a Docker
- **[contenedores-ii/](./contenedores-ii/)** - Día II: Trabajando con imágenes
- **[contenedores-iii/](./contenedores-iii/)** - Día III: Contenerización de aplicaciones
- **[contenedores-iv/](./contenedores-iv/)** - Día IV: Almacenamiento y monitorización
- **[contenedores-v/](./contenedores-v/)** - Día V: Networking
- **[contenedores-vi/](./contenedores-vi/)** - Día VI: Docker Compose y Docker Swarm
- **[lemoncode-challenge/](./lemoncode-challenge/)** - 🏆 Laboratorio final y desafíos

### 🎯 Contenido por Directorio

#### [`contenedores-i/`](./contenedores-i/) - Fundamentos Docker
- **README.md**: Guía completa del Día I
- **imagenes/**: Recursos visuales y diagramas
- **Contenido**: Instalación, primeros comandos, gestión básica de contenedores

#### [`contenedores-ii/`](./contenedores-ii/) - Gestión de Imágenes
- **README.md**: Guía completa del Día II
- **Dockerfile**: Ejemplos de construcción de imágenes
- **deberes-ii.sh**: Script con ejercicios prácticos
- **web/**: Aplicación de ejemplo para contenerizar
- **imagenes/**: Recursos visuales

#### [`contenedores-iii/`](./contenedores-iii/) - Contenerización Avanzada
- **README.md**: Guía completa del Día III
- **doom-web/**: Ejemplo práctico de aplicación web
- **imagenes/**: Recursos visuales
- **Contenido**: Dockerfiles multi-stage, buenas prácticas

#### [`contenedores-iv/`](./contenedores-iv/) - Persistencia y Monitoreo
- **README.md**: Guía completa del Día IV
- **web-content/**: Contenido para ejemplos de volúmenes
- **imagenes/**: Recursos visuales
- **Contenido**: Volúmenes, bind mounts, monitoring con Prometheus/Grafana

#### [`contenedores-v/`](./contenedores-v/) - Redes Docker
- **contenedores-v.sh**: Comandos y ejemplos prácticos
- **deberes-v.sh**: Ejercicios de networking
- **Dockerfile**: Ejemplos para testing de redes
- **01-load-balancer-host/**: Configuración de load balancer modo host
- **02-load-balancer-user-define-networks/**: Load balancer con redes personalizadas

#### [`contenedores-vi/`](./contenedores-vi/) - Orquestación
- **contenedores-vi.sh**: Comandos Docker Compose y Swarm
- **deberes-vi.sh**: Ejercicios de orquestación
- **docker-compose.yml**: Ejemplos de aplicaciones multi-contenedor
- **docker-compose-extension/**: Configuraciones avanzadas
- **my-app/**: Aplicación de ejemplo completa
- **stacks/**: Ejemplos de Docker Stacks para Swarm

#### [`lemoncode-challenge/`](./lemoncode-challenge/) - 🏆 Laboratorio Final
- **README.md**: Instrucciones del challenge
- **dotnet-stack/**: Stack completo con backend .NET
- **node-stack/**: Stack completo con backend Node.js
- **images/**: Recursos del laboratorio
- **Contenido**: Aplicación completa de 3 capas para dockerizar

## 🚀 Cómo usar este contenido

1. **Sigue el orden**: Los días están diseñados para construir conocimiento progresivamente
2. **Practica**: Cada directorio incluye ejercicios hands-on
3. **Experimenta**: Usa los scripts `.sh` para explorar comandos
4. **Completa el challenge**: El laboratorio final integra todo lo aprendido

## 📚 Agenda Detallada

### Día I: Introducción a Docker

#### Teoría
- Introducción a Docker y por qué Docker
- ¿Por dónde empiezo?
    * Docker Desktop    

#### Práctica

- Comandos básicos:
    * docker version y docker info
    * Ejecutar tu primer contenedor
    * Introducción a las imágenes
    * Docker Hub
    * Exponer puertos de un contenedor
    * ¿Dónde están los contenedores?
    * Personalizar el nombre de los contenedores
    * Ejecutar un contenedor y lanzar un terminal dentro de él
    * Conectarme a un contenedor
    * Ejecutar comandos dede mi local dentro del contenedor
    * Copiar archivos desde local a un contenedor y viceversa
    * Cómo parar/iniciar un contenedor ya creado    
    * Eliminar contenedores
    * Docker Desktop Dashboard para la gestión de contenedores
- Ejemplo práctico: SQL Server dockerizado
#### El resumen de hoy
#### Chuleta de comandos
#### Deberes

### Día II: Trabajando con imágenes (28 de Septiembre de 2021)

#### Teoría

- Introducción a las imágenes
- Los registros

#### Práctica

- Ver todas las imágenes en local hasta ahora
- Buscar entre las imágenes descargadas
- Descargar una imagen sin tener que ejecutar un contenedor
- Descargar una versión/tag específico de una imagen
- Descargar una imagen a través de su digest
- Descargar todas las versiones/tags de una imagen
- Pull desde un registro diferente a Docker Hub
- Buscar imágenes en Docker Hub con docker search
- Crear un contenedor a partir de una imagen de docker
- Crea tu propia imagen
  * El Dockerfile
  * Construir imagen a partir del Dockerfile
  * Histórico de una imagen
  * Inspeccionando una imagen
  * Dive: herramienta para explorar imágenes
  * Ejecutar un contenedor con tu nueva imagen
  * Subir tu imagen a Docker Hub
- Eliminar imágenes
#### El resumen de hoy
#### Chuleta de comandos
#### Deberes


### Día III: Contenerización de aplicaciones

#### Teoría

- ¿Por qué queremos contenerizar nuestras aplicaciones?
- Proceso de contenerización
- El Dockerfile
- Capas
- Cómo generar imágenes
- Publicar imágenes
- Buenas prácticas

### Prática

- Visual Studio Code y Docker
- Dockerfiles multi-stages
- Ejemplo de contenerizaión de una aplicación en un entorno .NET
- Ejemplo de aplicación Java con IntelliJ
- Ejemplo de aplicación con un contenedor Windows

#### El resumen de hoy
#### Chulera de comandos
#### Deberes

### Día IV: Almacenamiento y monitorización

#### Teoría del almacenamiento

- Introducción al almacenamiento
- Capas de lectura y del contenedor
- Datos persistentes
- Tipos de montaje

#### Práctica del almacenamiento

- Listar los volúmenes de un host
- Crear un nuevo volumen
- Asociar varios contenedores al mismo volumen
- Comprobar qué contenedores están asociados a un volumen
- Inspeccionar un volumen
- Añadir datos a un volumen
- Eliminar un contenedor con un volumen asociado
- Asociar un nuevo contenedor a un volumen existente
- Usar Visual Studio Code con Explore in Development Container
- Ejemplo de bind mount
- Usar el bind mount como read-only
- Backup de un volumen
- Eliminar un volumen
- Un volumen no puede eliminarse mientras esté atachado
- Eliminar todos los volúmenes que no estén siendo usados
- Tmpfs mount

#### Resumen de este apartado
#### Chuleta de comandos

#### Teoría de monitorización

- Introducción a la monitorización
- Tipos de logs
- Docker events
- Docker stats
- Docker logs

#### Práctica de monitorización

- Ver qué eventos genera Docker
- Métricas en Docker
- Saber cuánto espacio estamos ocupando en disco
- Prometheus
- Grafana
- Cómo ver los logs de un contenedor
- Fluentd
- Portainer.io

#### Resumen del apartado
#### Chuleta de comandos

### Día V: Networking

#### Teoría

- Fundamentos de redes
- ¿Qué es un DNS?
- Network namespaces
- Docker y el networking
- CNI
- CNM

#### Práctica

- Listar redes disponibles en un host
- Los contenedores por defecto se meten en la red bridge
- Dos contenedores en la red por defecto
- Cómo crear una red
- Añadir un contenedor a una red específica
- Asociar un contenedor a dos redes
- Lo que habíamos visto hasta ahora: port mapping
- Exponer todos los puertos descritos como EXPOSE en la imagen
- Ejemplo de un contenedor en la red de tipo host
- Deshabilitar la red para un contenedor
- Eliminar una red
- Eliminar todas las redes que no se estén utilizando
- Crear una red de tipo overlay
- Apartado Networks en Visual Studio Code

#### Resumen del día
#### Chuleta de comandos
#### Ejercicios

### Día VI: Docker Compose y Docker Swarm

#### Teoría de Docker Compose

- Introducción a los microservicios
- Introducción a Docker Compose

#### Práctica de Docker Compose

- Desplegar un Wordpress de forma manual
- El archivo docker-compose.yaml
- Ejecutar aplicación con Docker Compose
- Parar la aplicación
- Ejecutar la aplicación en segundo plano
- Eliminar la aplicación
- Desplegar una aplicación propia generando la imagen
- ver todas las aplicaciones que se están ejecutando a través de Docker Compose
- Ver todos los proyectos levantados con Docker Compose
- Asignar un nombre al proyecto
- Reiniciar los contenedores de la aplicación

#### Resumen de la parte de Docker Compose
#### Chuletas de Docker Compose

#### Teoría de Docker Swarm

- ¿Qué es Docker Swarm?
- ¿Cómo funciona?
- Alta disponibilidad
- Balanceo de Carga
* Modo Ingress
* Modo host

#### Práctica de Docker Swarm

- Como iniciar un clúster con Docker Swarm
- Docker Machine para crear VMs con Docker Engine
- Crear un clúster con Docker Machine
- Desplegar una aplicación en nuestro nuevo clúster
- Escalar la aplicación
- Constraints para desplegar los servicios solamente en los workers
- Visualizador de un Swarm
- Modo Ingress
- Modo Host
- Docker Stacks

#### Resumen de la parte de Docker Swarm
#### Chuleta de comandos
#### Ejercicios

## 🎓 Laboratorio Final - Lemoncode Challenge

El [`lemoncode-challenge/`](./lemoncode-challenge/) contiene un ejercicio integrador donde pondrás en práctica todo lo aprendido:

### 🎯 Objetivo
Dockerizar una aplicación completa de 3 capas:
- **Frontend**: Aplicación web en Node.js
- **Backend**: API REST (puedes elegir entre .NET o Node.js)
- **Base de datos**: MongoDB para persistencia

### 📋 Requisitos técnicos
- Crear red personalizada `lemoncode-challenge`
- Configurar comunicación entre servicios
- Implementar persistencia con volúmenes
- Exponer frontend en puerto 8080
- Poblar base de datos con estructura específica

### 💼 Stacks disponibles
- **`dotnet-stack/`**: Backend en .NET Core
- **`node-stack/`**: Backend en Node.js

## 🛠️ Herramientas y Comandos Principales

### Scripts de práctica incluidos:
- **`contenedores-v.sh`**: Comandos de networking
- **`deberes-v.sh`**: Ejercicios de redes
- **`contenedores-vi.sh`**: Docker Compose y Swarm
- **`deberes-vi.sh`**: Ejercicios de orquestación
- **`deberes-ii.sh`**: Ejercicios de imágenes

### Tecnologías cubiertas:
- **Docker Engine**: Gestión de contenedores
- **Docker Images**: Creación y gestión de imágenes
- **Docker Networks**: Comunicación entre contenedores
- **Docker Volumes**: Persistencia de datos
- **Docker Compose**: Aplicaciones multi-contenedor
- **Docker Swarm**: Orquestación y clustering
- **Docker Registry**: Distribución de imágenes

## 📖 Recursos adicionales

Cada directorio incluye:
- 📝 **README.md**: Guías detalladas paso a paso
- 🖼️ **imagenes/**: Diagramas y capturas explicativas
- 🔧 **Scripts**: Comandos listos para ejecutar
- 💡 **Ejemplos**: Aplicaciones reales para practicar
- 📋 **Chuletas**: Resúmenes de comandos importantes

¡Feliz aprendizaje con Docker! 🐳✨
