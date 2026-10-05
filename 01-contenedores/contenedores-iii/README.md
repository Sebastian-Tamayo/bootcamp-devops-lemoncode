# 🐳 Día 3: Contenerización de Aplicaciones

![Docker](./imagenes/Creando%20imagenes%20de%20Docker.jpeg)

¡Hola lemoncoders! 👋 En este tercer día del módulo de contenedores, nos centraremos en la **contenerización de aplicaciones**. Aprenderemos a crear imágenes de Docker 🐳 para nuestras aplicaciones, optimizarlas utilizando técnicas como **multi-stage builds** 🏗️ y publicarlas en Docker Hub 🌐.

## 🎬 Vídeos de la introducción en el campus

Se asume que has visto los siguientes vídeos para comenzar con este módulo:

| # | Tema | Contenido Clave |
|---|------|-----------------|
| 1 | 📘 Teoría | Diseño de imágenes para aplicaciones, buenas prácticas (imagen base mínima, usuario no root, capas ordenadas), estrategias de multi-stage build y diferencias entre entornos dev y prod. |
| 2 | 🛠️ Demo: Ejecutar la aplicación en local | Arranque de la app Node.js (doom-web/) sin Docker, revisión de dependencias (package.json) y endpoints básicos. |
| 3 | 🏷️ Demo: Mi primera contenerización | Una vez que ya sabemos qué vamos a contenerizar, crearemos un Dockerfile básico. |
| 4 | 🌐 Demo: Diferentes Dockerfiles para diferentes cometidos | Separación de Dockerfile (prod), Dockerfile.dev (bind mounts, nodemon) y optimizaciones iniciales. Uso de argumentos y variables de entorno. |
| 5 | 🧪 Demo: Dockerfiles con multistages | Implementación de Dockerfile.multistages para reducir tamaño: stage build (instalación completa y build si aplica) y stage runtime (imagen ligera final solo con artefactos necesarios). |

---

## 🚀 Aplicación de ejemplo

Para contenerizar una aplicación lo primero que necesitamos es un aplicativo que queramos contenerizar. En este caso, vamos a contenerizar una aplicación, un poquito más real que lo que vimos en la clase anterior, donde sólo pegabamos código estático. En este caso vamos a utilizar una aplicación en **Node.js** 🟢, no te preocupes, tampoco muy complicada, que está dentro del directorio `doom-web`. Y antes de contenerizarla es aconsejable ejecutarla en local para comprobar que funciona correctamente.

```bash
cd 01-contenedores/contenedores-iii/doom-web
npm install
npm run test
npm start
npm run start-dev
```

> [!NOTE]
> 💡 Ejemplo sacado de https://codepen.io/cobra_winfrey/pen/oNOMRav

## 📝 El archivo Dockerfile

Para poder contenerizar cualquier aplicación necesitamos un archivo llamado `Dockerfile`. Este archivo contiene las instrucciones necesarias para construir una imagen de Docker 🐳. Para conseguir este archivo tenemos varias maneras:

### ✍️ 1. De forma manual

En este caso necesitamos conocer los comandos necesarios para construir una imagen de Docker. Puedes encontrar todos los que existen en la [documentación oficial](https://docs.docker.com/engine/reference/builder/). Para este caso, vamos a utilizar un archivo `Dockerfile` que ya está creado en el directorio `doom-web` llamado `Dockerfile`.


### ⚡ 2. Usando `docker init` en Docker CLI

El comando `docker init` es una herramienta interactiva que te ayuda a generar un Dockerfile y otros archivos necesarios para contenerizar tu aplicación sin tener que escribir todo desde cero.

#### 🎯 Ventajas de usar `docker init`

- **🚀 Rápido**: Genera un Dockerfile completo en segundos
- **🎓 Educativo**: Te enseña las mejores prácticas automáticamente
- **🔧 Inteligente**: Detecta el tipo de proyecto (Node, Python, Go, etc.)
- **✅ Validado**: Produce Dockerfiles que siguen estándares

#### 📋 Paso a paso

Primero, asegúrate de que tienes Docker 4.18.0 o superior:

```bash
docker --version
```

Ahora, dentro del directorio de tu proyecto:

```bash
# Navega a la carpeta de tu proyecto
cd doom-web

# Ejecuta docker init
docker init
```

Se te hará una serie de preguntas interactivas:

```
Welcome to the Docker Init CLI!

This utility will walk you through creating the necessary Docker files
for your project as simple as possible.

Looking at your project files, we recommend the following configuration:

? Include optional metadata (author, description)? [y/N] y
? Your name: Your Name
? Description: A Doom-inspired web application
? Detected language: node. Is this correct? [Y/n] Y
? Port to expose: 3000
```

Esto generará:

- `Dockerfile` - Para producción
- `.dockerignore` - Archivos a ignorar
- `compose.yaml` - Para desarrollo con Docker Compose (opcional) Se verá más adelante


### 🆚 3. Usando la extensión de Docker de Visual Studio Code

La extensión oficial de Docker para VS Code ofrece una forma visual e interactiva de generar Dockerfiles.

#### 🔧 Instalación

1. Abre VS Code
2. Ve a Extensions (Ctrl+Shift+X en Linux/Windows, Cmd+Shift+X en Mac)
3. Busca "Docker"
4. Instala la extensión oficial de Docker

#### 📝 Generación automática

Una vez instalada, haz lo siguiente:

1. Abre la paleta de comandos: `Cmd + P` (Mac) o `Ctrl + P` (Linux/Windows)
2. Escribe: `Add Docker Files to Workspace`
3. Selecciona el comando

Se abrirá un asistente:

```
Select Application Platform
├─ Node
├─ Python
├─ Go
├─ .NET
└─ Java
```

Para nuestro caso, selecciona **Node**.

#### 🎯 Configuración del asistente

El asistente te pedirá:

- **Package.json location**: Selecciona el `package.json` de tu proyecto
- **Port**: El puerto que expone tu aplicación (3000 para doom-web)
- **Include optional Docker Compose file**: Selecciona NO por ahora (lo veremos después)
- **Include Docker Compose file for debugging**: NO

---

### 🤖 4. Usando `docker ai` - AI Gordon 🦾

Docker ha introducido **Docker AI**, un agente de IA que te ayuda a generar Dockerfiles inteligentes usando tecnología de IA.

#### 📋 Requisitos

- **Docker Desktop 4.27.0+** o superior
- Haber iniciado sesión con tu cuenta Docker
- Acceso a Docker AI habilitado en Settings > Beta features

#### 🔐 Configurar Docker AI

1. Abre Docker Desktop
2. Ve a **Settings > Beta features**
3. Habilita **"Use Docker AI"**
4. Asegúrate de haber hecho login con tu cuenta Docker

#### 🚀 Uso básico

Desde la terminal, en el directorio de tu proyecto:

```bash
# Solicitar generación de Dockerfile
docker ai "Quiero contenerizar una aplicación Node.js con Express que expone el puerto 3000"
```

O de forma más específica:

```bash
docker ai "Crea un Dockerfile para una aplicación Node.js con:
- Puerto 3000
- Soporte para desarrollo y producción
- Usuario no-root
- Multi-stage build
- Node 20-alpine"
```

#### 💡 Ejemplos de prompts útiles

```bash
# Generar Dockerfile optimizado
docker ai "Optimiza este Dockerfile para producción"

# Debuggear problemas
docker ai "Mi imagen Docker pesa 500MB, ¿cómo la puedo reducir?"

# Seguridad
docker ai "¿Cuáles son las prácticas de seguridad que debería implementar en mi Dockerfile?"

# Multi-arquitectura
docker ai "Necesito soportar linux/amd64 y linux/arm64. ¿Cómo lo hago?"
```

#### ⚙️ Configuración avanzada

Puedes hacer prompts más complejos:

```bash
docker ai "
Crea un Dockerfile multi-stage que:
1. En el stage de build: instale todas las dependencias y ejecute tests
2. En el stage de desarrollo: tenga nodemon y herramientas de debug
3. En el stage de producción: solo lo necesario para ejecutar la app
4. Utilice variables de entorno para NODE_ENV
5. Implemente health checks
"
```

> [!NOTE]
> 💡 Docker AI está en fase beta y requiere conexión a internet.

### 🌐 5. Usando Microsoft Edge Copilot

Microsoft Edge incluye **Copilot**, una herramienta de IA integrada que puede ayudarte a generar Dockerfiles.

#### 🔧 Requisitos

- Tener **Microsoft Edge** instalado
- Estar en una versión reciente de Edge
- Tener la interfaz de Copilot activa

#### 🚀 Pasos

1. **Abre tu proyecto en VS Code** dentro de Edge (o el navegador)

2. **Abre Copilot** en Edge:
   - En la parte derecha del navegador, busca el icono de Copilot 🤖
   - O presiona `Ctrl+Shift+Y` (Windows) / `Cmd+Shift+Y` (Mac)

3. **Selecciona tu archivo** que quieres contenerizar en VS Code

4. **Realiza tu pregunta en Copilot**:
   ```
   ¿Puedes crearme un Dockerfile para este proyecto Node.js?
   ```

5. **Copilot generará** un Dockerfile personalizado basado en el contenido de tu proyecto

#### 📋 Ejemplo de interacción

**Tu pregunta:**
```
Crea un Dockerfile para contenerizar esta aplicación Node.js.
La app usa Express, debe exponer el puerto 3000, y necesito
una versión de desarrollo y otra de producción.
```



### 🐙 6. Usando GitHub Copilot

GitHub Copilot es una extensión de IA para tu IDE que genera código con contexto completo de tu editor.

#### 🔧 Instalación

1. Abre VS Code
2. Ve a Extensions (Cmd+Shift+X)
3. Busca "GitHub Copilot"
4. Instala la extensión oficial de GitHub
5. Inicia sesión con tu cuenta GitHub

#### 🎯 Generar Dockerfile

**Opción 1: Sugerencias automáticas**

1. Crea un archivo llamado `Dockerfile`
2. Escribe `FROM` y presiona Tab
3. GitHub Copilot sugerirá el resto automáticamente

**Opción 2: Chat de Copilot**

1. Abre la paleta de comandos: `Cmd + Shift + P`
2. Escribe: `GitHub Copilot: Open Copilot Chat`
3. Escribe tu pregunta:
   ```
   Crea un Dockerfile multi-stage para una app Node.js que:
   - Use node:20-alpine
   - Tenga stage de build y stage de runtime
   - Ejecute tests en el build
   - Sea seguro (usuario no-root)
   ```

#### 🚫 El archivo .dockerignore

Aunque es un archivo opcional es más que recomendado el uso del archivo `.dockerignore`. Este archivo se utiliza para indicar a Docker qué archivos y carpetas no debe incluir en la imagen. Es muy útil para evitar incluir archivos innecesarios en la imagen, como por ejemplo archivos de logs 📄, archivos temporales ⏱️, etc.

#### 🔨 Generar la imagen en base al Dockerfile

Una vez que tenemos el archivo `Dockerfile` y el archivo `.dockerignore` podemos generar la imagen de Docker. Para ello, necesitamos ejecutar el siguiente comando:

```bash
docker build -t doom-web:v1 .
```

Si ahora comprobamos las imágenes que tenemos en nuestro sistema, deberíamos ver la imagen que acabamos de crear:

```bash
docker images
```

Si queremos ver el historial de la imagen que acabamos de crear, podemos ejecutar el siguiente comando:

```bash
docker history doom-web:v1
```

## ▶️ Ejecutar un nuevo contenedor usando tu nueva imagen:

```bash
docker run -p 8080:3000 doom-web:v1
```

## 🏗️ Imágenes multi-stage

Cuando creamos imágenes de Docker, a veces necesitamos instalar herramientas adicionales para construir nuestra aplicación, como por ejemplo compiladores 🔧, linters 🔍, herramientas de testing 🧪, etc. Sin embargo, estas herramientas no son necesarias en la imagen final, ya que solo necesitamos el binario de nuestra aplicación. Si no lo tenemos en cuenta, nuestra imagen final será más grande de lo necesario.

Para que lo veas con un ejemplo, vamos a instalar todo lo que nuestra aplicación potencialmente puede instalar, para ello modifica el Dockerfile para ejecutar el test con eslint:

```Dockerfile
FROM node:20-alpine

LABEL maintainer="Gisela Torres <gisela.torres@returngis.net>"

# ENV NODE_ENV=production

WORKDIR /usr/src/app

COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]

RUN npm install

COPY . .
# #Ejecuta los tests de eslint
RUN npm test

EXPOSE 3000

RUN chown -R node /usr/src/app

USER node

CMD ["npm", "start"]
```

Ahora, si volvemos a generar la imagen, después de que arregles los errores que reporta eslint, comprobarás que ha engordado 📈.

```bash
docker build --tag=doom-web:v2 . -f Dockerfile.dev
docker images
```

En este caso la imagen "solo" pesa 25MB mega más que la anterior, pero si tu aplicación es más grande, la diferencia puede ser mucho mayor.

### 🎭 Multi-stage Builds 

Con multi-stage lo que se hace es utilizar múltiples `FROM` dentro del mismo Dockerfile.
- Cada `FROM` utiliza una imagen base diferente y cada una inicia un nuevo stage o paso en la construcción de la imagen
- El último `FROM` produce la imagen final, el resto solo serán intermediarios
- Puedes copiar archivos de un stage a otro, dejando atrás todo lo que no quieres para la imagen final
- La idea es simple: crea imagenes adicionales con las herramientas que necesitas (compiladores, linters, herramientas de testing, etc.) pero que no son necesarias para producción
- El objetivo final es tener una imagen productiva lo más **fit** 🏃‍♀️ posible y **segura** 🔒

Mismo ejemplo con multi-stages:

```bash
docker  build -t doom-web:multi-stage . -f Dockerfile.multistages
```

Si revisamos las imágenes finales, `doom-web:v1` y `doom-web:multi-stage` deberían de tener el mismo peso

```bash
docker images
```

Existen lo que se llaman las imágenes intermedias, o dangling images, que son las que se generan en cada uno de los stages. Para eliminarlas, podemos ejecutar el siguiente comando:

```bash
docker image prune
```

Y como puedes ver, la imagen generada con multi-stage es mucho más pequeña que la generada sin multi-stage. ✨

## Docker debug

En la última versión de Docker Desktop disponible en la fecha de la última edición de este contenido, la v4.49, se ha puesto a disposición de todos los usuarios la funcionalidad llamada [Docker Debug](https://docs.docker.com/reference/cli/docker/debug/). Esta funcionalidad nos permite depurar nuestras imágenes de Docker de una manera muy sencilla.

```bash
docker debug doom-web:multi-stage
```

Esta comando es útil cuando quieres explorar o probar cosas dentro de esa imagen que has creado sin tener que instalar imágenes adicionales que no quieres que formen parte de tu imagen final.

y esto también valdría para un contenedor en ejecución:

```bash
docker debug <container_id>
```

Esto en realidad lo que hace es crear un contenedor con una imagen especial de depuración basada en la distribución de Linux NixOS, que tiene un montón de herramientas de depuración preinstaladas, como `curl`, `wget`, `vim`, `htop`, `strace`, etc. Puedes ver todas las herramientas disponibles en la [documentación oficial](https://docs.docker.com/reference/cli/docker/debug/#debug-image-included-tools). También monta el sistema de archivos de la imagen o contenedor que estás depurando, por lo que puedes explorar los archivos y directorios como si estuvieras dentro del contenedor original. Además, si necesitas instalar alguna herramienta adicional, puedes hacerlo utilizando simplemente `install <tool>`.

## Depurar la construcción de la imagen

Por otro lado, también a día de hoy existe la posibilidad de depurar la construcción de la imagen usando la extensión Docker DX y Visual Studio Code.

---

## 🌍 Crear imágenes multi-arquitectura

A día de hoy, tenemos que preparar nuestras aplicaciones para que se ejecuten en diferentes arquitecturas (Intel/AMD x86_64, ARM, ARM64, etc.). Docker permite crear imágenes que funcionen en múltiples plataformas.

### 🎯 ¿Por qué multi-arquitectura?

- **🖥️ Desarrollo local**: Desarrollo en Mac M1/M2 (ARM64)
- **☁️ Producción en cloud**: Servidores Intel en AWS/GCP/Azure (x86_64)
- **📱 Edge computing**: Dispositivos ARM como Raspberry Pi
- **📦 Compatibilidad**: Una sola imagen para todos

### 🛠️ Requisitos

- Docker Desktop con BuildKit activado (por defecto en versiones recientes)
- Docker Buildx habilitado


Verifica que tienes buildx:

```bash
docker buildx ls
```

>[!NOTE]
>Si no aparece nada, actualiza Docker Desktop.

### 📋 Arquitecturas soportadas

Las más comunes:

| Arquitectura | Alias | Descripción |
|---|---|---|
| `linux/amd64` | x86_64 | Intel/AMD 64-bit |
| `linux/arm64` | aarch64 | ARM 64-bit (Mac M1/M2, algunos servidores) |
| `linux/arm/v7` | armhf | ARM 32-bit (Raspberry Pi 2/3) |
| `linux/386` | i386 | Intel 32-bit (Obsoleto) |
| `linux/ppc64le` | ppc64le | PowerPC 64-bit |
| `windows/amd64` | - | Windows 64-bit |

### 🚀 Crear imagen multi-arquitectura

Lo cierto es que crear una imagen multi-arquitectura es tan sencillo como especificar las plataformas que queremos soportar con la opción `--platform`.

```bash
# Construir para múltiples arquitecturas (sin push)
docker build \
  --platform linux/amd64,linux/arm64 \
  -t doom-web:v4 \
  --load .
```

El parámetro `--load` carga la imagen en el daemon local después de construirla. ¿Qué significa esto? Pues que la imagen estará disponible localmente para ejecutar contenedores.

En contraste, si usamos `--push`, la imagen se subirá directamente a un registro (Docker Hub, etc.) y no estará disponible localmente.


>[!NOTE]
> Antiguamente era necesario usar docker buildx build para esto, pero ahora docker build  es en realidad un alias a docker buildx build.

El resultado será una imagen que contiene múltiples variantes para cada arquitectura especificada. Se puede ver de forma sencilla a través de Docker Desktop:

![Docker Desktop multi-arch](./imagenes/Imagen%20multi-arquitectura%20con%20docker%20build.png)


### 🔍 Inspeccionar imagen multi-arquitectura

```bash
docker manifest inspect doom-web:v4
```

o bien

```bash
docker inspect doom-web:v4 --format='{{.Architecture}} {{.Os}}'
```

## 🏗️ Diferentes Builders en Docker

Docker Buildx proporciona múltiples **builders** que podemos usar para optimizar nuestras construcciones.

### 🎯 ¿Qué es un Builder?

Un builder es una instancia del motor de construcción de Docker que ejecuta los builds. Diferentes builders tienen diferentes capacidades y configuraciones:

- **docker-container**: Completo, soporta multi-arch, pero más lento
- **docker**: Nativo del daemon, más rápido pero limitado
- **kubernetes**: Para entornos de Kubernetes
- **remote**: Builders remotos para CI/CD

### 📋 Ver builders disponibles

```bash
docker buildx ls
```

### ¿Por qué usar diferentes builders?

- **⚡ Velocidad**: Algunos builders son más rápidos para builds simples
- **🌐 Multi-arquitectura**: Algunos soportan múltiples arquitecturas
- **🔄 CI/CD**: Builders remotos para integración continua


### 🆕 Crear un builder personalizado

#### Builder 1: Optimizado para velocidad (docker-container)

```bash
docker buildx create \
  --name fast-builder \
  --driver docker-container \
  --use \
  --bootstrap
```

Este builder:
- Ejecuta en un contenedor separado
- Soporta multi-arquitectura
- Mejor rendimiento en builds complejos

Para usarlo:

```bash
docker buildx use fast-builder
```

y podemos probarlo con:

```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t doom-web:v5 \
  --load .
```

o si no hemos indicado `--use`:

```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t doom-web:v5 \
  --builder fast-builder \
  --load .
```

#### Builder para Kubernetes

```bash
docker buildx create \
  --name k8s-builder \
  --driver kubernetes \
  --use
```

Requiere estar conectado a un cluster de Kubernetes:

```bash
docker buildx create \
  --name k8s-builder \
  --driver kubernetes \
  --allow-insecure-entitlement security.insecure \
  --use
```

### 🎛️ Gestionar builders

```bash
# Listar todos los builders
docker buildx ls

# Ver información detallada
docker buildx du

# Usar un builder específico
docker buildx use fast-builder

# Inspeccionar builder
docker buildx inspect fast-builder

# Eliminar builder
docker buildx rm fast-builder

# Detener builder
docker buildx stop fast-builder

# Reiniciar builder
docker buildx start fast-builder
```
---

## 🔍 Docker Build Checks

**Docker Build Checks** es una característica introducida en Dockerfile 1.8 que te permite validar tu configuración de build y realizar una serie de verificaciones antes de ejecutar tu build. Es como un **linter avanzado** para tu Dockerfile y opciones de build, o un modo de **dry-run** para builds. 🎯

### 🌟 ¿Por qué usar Build Checks?

- **✅ Validación temprana**: Detecta problemas antes de ejecutar el build
- **📋 Mejores prácticas**: Asegura que tu Dockerfile sigue las recomendaciones actuales
- **🚫 Anti-patrones**: Identifica patrones problemáticos en tu configuración
- **🔒 Seguridad**: Ayuda a detectar configuraciones inseguras
- **⚡ Eficiencia**: Ahorra tiempo evitando builds fallidos


### 🚀 Uso básico

Por defecto, los checks se ejecutan automáticamente cuando haces un build:


```bash
docker build . -f Dockerfile.checks
```

Deberías ver warnings o errores si tu Dockerfile no sigue las mejores prácticas.


### 🔍 Verificar sin construir

Para ejecutar solo los checks sin construir la imagen:

```bash
docker build --check . -f Dockerfile.checks
```

Si quieres que la build falle en caso de warnings añade estas dos líneas al inicio de tu Dockerfile:


```dockerfile
# syntax=docker/dockerfile:1
# check=error=true
```
O en el Dockerfile:

```dockerfile
# syntax=docker/dockerfile:1
# check=experimental=all
```

#### 🔧 Combinando parámetros

Puedes combinar múltiples configuraciones separándolas con punto y coma:

```dockerfile
# syntax=docker/dockerfile:1
# check=skip=JSONArgsRecommended;error=true;experimental=all
```

Por otro lado, si tienes instalada la extensión Docker DX también verás los warnings y errores directamente en el editor de Visual Studio Code. 🖥️


### 🔧 Checks más comunes

| Check | Descripción | Ejemplo problemático | Solución |
|-------|-------------|---------------------|----------|
| **JSONArgsRecommended** | CMD/ENTRYPOINT deberían usar formato JSON | `CMD npm start` ❌ | `CMD ["npm", "start"]` ✅ |
| **StageNameCasing** | Nombres de stage deberían estar en minúsculas | `FROM alpine AS BASE_STAGE` ❌ | `FROM alpine AS base` ✅ |
| **FromAsCasing** | La palabra AS debería estar en mayúsculas | `FROM alpine as base` ❌ | `FROM alpine AS base` ✅ |
| **NoEmptyCommand** | Comandos no deberían estar vacíos | `RUN` ❌ | `RUN echo "hello"` ✅ |
| **UndefinedVariable** | Variables no definidas en ARG | `RUN echo $UNDEFINED` ❌ | `ARG MY_VAR` y luego usar ✅ |
| **SeeminglyEmptyBase** | Imagen base muy grande | `FROM ubuntu` ❌ | `FROM alpine` ✅ |
| **OfficialRepositoriesDiscouraged** | Usar registros que no sean oficiales | - | Usar tags específicos |

### 📊 Integración con CI/CD

#### GitHub Actions

```yaml
name: Docker Build with Checks
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
      
      - name: Run build checks
        uses: docker/build-push-action@v6.6.0
        with:
          context: .
          push: false
          build-args: |
            BUILDKIT_DOCKERFILE_CHECK=error=true
```

Los checks aparecerán como anotaciones en las pull requests de GitHub! 📝

### 💡 Mejores prácticas

1. **🎯 Usa checks desde el inicio**: Integra checks en tu workflow de desarrollo
2. **⚠️ Trata warnings como errores**: Usa `check=error=true` en producción
3. **📋 Documenta excepciones**: Si skips checks, documenta por qué
4. **🔄 Actualiza regularmente**: Los checks evolucionan con las mejores prácticas
5. **👥 Estandariza en equipo**: Usa la misma configuración en todo el proyecto


---

## 📦 Publicar nuestras imágenes en Docker Hub

Para poder publicar nuestras imágenes en Docker Hub, lo primero que necesitamos es tener una cuenta en Docker Hub. Si no tienes una, puedes crear una cuenta gratuita en [https://hub.docker.com/](https://hub.docker.com/) 🆓. Hay un plan gratuito que te permite tener ilimitados repositorios públicos y un repositorio privado.

Una vez que la tengas, necesitas hacer login bien a través del terminal:

```bash
docker login
```

O bien a través de **Docker Desktop** 🖥️.

### 🏷️ Bautizar las imagenes correctamente

Para poder publicar nuestras imágenes en Docker Hub, necesitamos bautizarlas correctamente. El nombre de la imagen debe seguir el siguiente formato:

```
<nombre-de-usuario-o-organización-en-docker-hub>/<nombre-de-la-imagen>:<tag>
```

Por ejemplo, si mi usuario en Docker Hub es `0GiS0` y la imagen se llama `doom-web` y le quiero poner el tag `v1`, el nombre de la imagen sería:

```
0GiS0/doom-web:v1
```

Si no especificamos un tag, Docker utilizará el tag `latest` por defecto.

Vamos a probarlo:

```bash
docker build -t 0gis0/doom-web:v1 .
```

Una vez que tenemos la imagen creada, necesitamos hacer push de la imagen a Docker Hub:

```bash
docker push 0gis0/doom-web:v1
```

También se puede hacer en un único paso:

```bash
docker build -t 0gis0/doom-web:v1 . --push
```

Si ahora vamos a Docker Hub, deberíamos ver la imagen que acabamos de subir. 🎉

También puedes añadir alias a las imágenes existentes para que no tengas que volver a hacer el proceso de build:

```bash
docker tag doom-web:v1 0gis0/doom-web:v2
docker push 0gis0/doom-web:v2
```

### 🏷️ Nomenclatura de tags

Es una buena práctica usar tags significativos:

```bash
# Tags por versión
docker build -t tu-usuario/doom-web:1.0.0 .
docker build -t tu-usuario/doom-web:1.0 .
docker build -t tu-usuario/doom-web:latest .

# Tags por fecha
docker build -t tu-usuario/doom-web:2024-11-01 .

# Tags por ambiente
docker build -t tu-usuario/doom-web:prod .
docker build -t tu-usuario/doom-web:staging .
docker build -t tu-usuario/doom-web:dev .

# Tags descriptivos
docker build -t tu-usuario/doom-web:v1.0-alpine .
docker build -t tu-usuario/doom-web:v1.0-ubuntu .
```

### 🔗 Crear alias de imágenes

```bash
# Crear alias sin rebuildar
docker tag doom-web:v1 tu-usuario/doom-web:latest
docker tag doom-web:v1 tu-usuario/doom-web:stable

# Push de todos los alias
docker push tu-usuario/doom-web:v1
docker push tu-usuario/doom-web:latest
docker push tu-usuario/doom-web:stable
```

### 📊 Ver información de push

```bash
# Ver progreso detallado
docker push -a tu-usuario/doom-web
```

---

## 🎯 Docker Bake - Definir configuraciones como código

**Docker Bake** es una característica avanzada de Docker Buildx que te permite definir tu configuración de build usando un archivo declarativo, en lugar de especificar una expresión CLI compleja. También te permite ejecutar múltiples builds de forma concurrente con una sola invocación. 🚀

### 🌟 ¿Por qué usar Docker Bake?

- **📋 Configuración estructurada**: Gestiona builds complejos de manera organizada
- **🔄 Builds concurrentes**: Ejecuta múltiples targets simultáneamente
- **👥 Compartir configuración**: Consistencia entre equipos
- **🎛️ Múltiples formatos**: Soporta HCL, JSON y YAML
- **⚙️ Variables**: Reutilización de configuración
- **📦 Grupos**: Agrupar builds relacionados

### 📝 Ejemplo básico

En lugar de usar un comando largo como:

```bash
docker build \
  -f Dockerfile \
  -t myapp:latest \
  --build-arg foo=bar \
  --no-cache \
  --platform linux/amd64,linux/arm64 \
  .
```

Puedes crear un archivo como `docker-bake.hcl`y ejecutarlo simplemente con:

```bash
docker buildx bake
```

---

## 📚 Resumen de lo aprendido

En este módulo hemos cubierto los aspectos fundamentales de la contenerización de aplicaciones con Docker:

### 🔧 Conceptos clave aprendidos:

1. **📝 Dockerfile**: Archivo de instrucciones para construir imágenes
   - Comandos básicos (`FROM`, `COPY`, `RUN`, `EXPOSE`, etc.)
   - Mejores prácticas de seguridad y optimización

2. **🚫 .dockerignore**: Exclusión de archivos innecesarios
   - Reduce el tamaño de la imagen
   - Mejora la seguridad excluyendo archivos sensibles

3. **🏗️ Multi-stage builds**: Optimización de imágenes
   - Separación entre entorno de build y producción
   - Imágenes más ligeras y seguras
   - Reutilización de capas intermedias


4. **🌍 Imágenes multi-arquitectura**: Compatibilidad amplia
   - Soporte para múltiples plataformas (x86_64, ARM64, etc.)
   - Uso de `--platform` en builds
   - Inspección y gestión de manifestos

5. **✅ Docker Build Checks**: Validación y linting avanzado
   - Detección temprana de problemas en Dockerfiles
   - Verificación de mejores prácticas de seguridad
   - Integración con CI/CD para calidad de código

6. **⬆︎📦 Publicación en Docker Hub**: Distribución de imágenes
   - Nomenclatura correcta de imágenes
   - Autenticación y push de imágenes
   - Gestión de tags y versiones

7. **🎯 Docker Bake**: Gestión avanzada de builds
   - Configuración declarativa en HCL/JSON/YAML
   - Builds concurrentes y paralelos
   - Mejor organización para proyectos complejos


## 🎓 Ejercicios propuestos

### 🐍 Aplicación de ejemplo: Confetti Party Web

Tu misión será contenerizar una aplicación web simple en Python que se encuentra en el directorio `confetti-web`.

Como ya te comenté al inicio de esta clase, siempre es recomendable ejecutar la aplicación localmente antes de contenerizarla para asegurarte de que funciona correctamente.

```bash
# Instalar dependencias
pip install -r requirements.txt

# Ejecutar la aplicación
python app.py
```

Haz clic en la URL local que te muestra la aplicación para verificar que la aplicación funciona correctamente.


## 🌍 Ejercicio 2: Distribución multi-arquitectura y publicación

### 📋 Objetivo

Crear y publicar una imagen multi-arquitectura, de la aplicación anterior, en Docker Hub con al menos soporte para `linux/amd64` y `linux/arm64`. Implementar una estrategia de tagging efectiva y utilizar Docker Build Checks para asegurar la calidad de la imagen. Además, crear una configuración de Docker Bake para facilitar futuras construcciones.


> [!SUCCESS]
> 🎉 **¡Felicitaciones!** Ya dominas los fundamentos de la contenerización. Estás listo para el siguiente nivel: orquestación de contenedores.