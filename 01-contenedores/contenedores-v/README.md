# 🛜 Día V: Docker Networking

![Docker](imagenes/Docker%20y%20el%20networking.png)!

¡Hola lemoncoder 👋🏻🍋 !  En esta lección aprenderemos cómo conectar contenedores entre sí y con el mundo exterior. Cubriremos los diferentes tipos de redes disponibles en Docker y cómo gestionarlas.En esta lección aprenderemos cómo conectar contenedores entre sí y con el mundo exterior. Cubriremos los diferentes tipos de redes disponibles en Docker y cómo gestionarlas.

## 🎬 Vídeos de la introducción en el campus

Se asume que has visto los siguientes vídeos para comenzar con este módulo:

| # | Tema | Contenido Clave |
|---|------|-----------------|
| 1 | Teoría - Basics networking | Para ponernos un poco al día de conceptos básicos de networking en general |
| 2 | Teoría - Redes en Docker | Tipos de redes y cómo funcionan |
| 3 | Demo 1 - Listar redes y probar la red bridge | En esta demo, listaremos las redes disponibles y probaremos la conectividad en la red bridge. |
| 4 | Demo 2 - Cómo crear redes | En esta demo, crearemos redes personalizadas y conectaremos contenedores a ellas. |
| 5 | Demo 3 - Red de tipo host | En esta demo, exploraremos la red de tipo host y cómo se comporta en comparación con otras redes. |
| 6 |  Demo 4 - Conectarse a la red no red | Uso de --network none, aislamiento completo y escenarios de pruebas / hardening. |

---

## ¿Qué es Docker Networking?

Docker Networking permite que los contenedores se comuniquen entre sí y con sistemas externos. Cada contenedor puede estar conectado a una o más redes, facilitando la comunicación en función de las necesidades de la aplicación.

Hasta ahora has estado usando la red por defecto en Docker, sin tu saberlo 🥲. Asi que durante esta clase vamosa a centrarnos con más cariño en toda la parte que tiene que ver con la conectividad entre mis contenedores.

### Listar redes disponibles

Lo primero que necesitas saber es qué tipo de redes podemos usar en Docker.

Para ver las redes disponibles en tu host:

```bash
docker network ls
```

Las redes por defecto incluyen:

- `bridge`: Red por defecto para contenedores en una sola máquina

- `host`: El contenedor comparte la red del host

- `none`: El contenedor no tiene conectividad de red


## Red Bridge

La red bridge es la red por defecto de Docker. Proporciona aislamiento de red entre contenedores y el host.


### Inspeccionar la red bridge

Para poder ver la configuración de una red específica, usamos el comando `docker network inspect`:

```bash
docker network inspect bridge
```

También es bastante cómodo apoyarnos en herramientas como `jq` para formatear la salida JSON:

```bash
docker network inspect bridge --format '{{json .Containers}}' | jq
```

Esta es la red donde todo ha estado funcionando hasta ahora sin que te dieras cuenta 😉. Asi que ahora vamos a usar la misma con conocimiento de causa.

### Crear contenedores en la red bridge

Para crear un contenedor en la red bridge (que es la red por defecto), simplemente ejecutamos:


```bash
docker run -d --name web nginx

docker run -d --name web-apache httpd
```

Si ahora echamos la red bridge, veremos que ambos contenedores están conectados a ella:

```bash
docker network inspect bridge --format '{{json .Containers}}' | jq
```

### Comunicación entre contenedores

Ya que estamos en una red, yo puedo hacer que dos contenedores se comuniquen entre sí.

```bash
docker exec -ti web /bin/bash
```

# Instalar herramientas de red

```bash
apt update && apt -y install net-tools iputils-ping
```


O ahora también puedo usar el comando debug de docker:

```bash
docker debug web
```
Y este ya viene con la herramienta necesaria para hacer ping.

```bash
ping 172.17.0.3
```

Sin embargo, si yo intento hacer ping por nombre de contenedor, no va a funcionar:

```bash
ping web-apache
```

[!NOTE]>
>Esta limitación se resuelve usando redes personalizadas. 

## Redes personalizadas

Las redes personalizadas permiten que los contenedores se comuniquen entre sí por su nombre, en lugar de por su dirección IP, gracias a un servidor DNS integrado. Esta es la mejor práctica para aplicaciones multi-contenedor.


### Ventajas de las redes personalizadas

- ✅ Resolución DNS automática por nombre de contened

- ✅ Mejor aislamiento y seguridad

- ✅ Control total sobre la conectividad

- ✅ Flexibilidad para conectar y desconectar contenedores


### Crear una red personalizada#

Para poder crear una red personalizada, usamos el comando `docker network create`:

```bash
docker network create lemoncode-net
```

Y puedes confirmar que la misma se ha creado sin problemas usando de nuevo el comando:

```bash
docker network ls
```

También puedes inspeccionarla de la misma forma que hicimos con bridge:

```bash
docker network inspect lemoncode-net
```

Y verás que la misma tiene asignado un rango de IPs diferente al de bridge.

### Crear contenedores en una red personalizada

Vale y ahora ¿Cómo la uso?

Lo único que debes añadir como parte del comando `docker run` es el flag `--network` seguido del nombre de la red personalizada que acabas de crear:

```bash
docker run -d --name lemon-web --network lemoncode-net nginx
```

# Acceder al contenedor

```bash
docker debug lemon-web
```

[!NOTE]>
>Si es la primera vez que usas `docker debug`, tendrás que instalar el paquete ifconfig-net-tools. Ping ya está incluido.


# Ver que no puede alcanzar la red bridge

Si ahora quisieramos intentar comunicarnos con un contenedor que está en la red bridge, no vamos a poder:

```bash
ping 172.17.0.2
```

# Crear contenedor Apache en la misma red personalizadaexit

```bash
docker run -d --name lemon-apache --network lemoncode-net httpd
```

Podrás ver que ahora sí ambos contenedores están en la misma red personalizada:

```bash
docker network inspect lemoncode-net
```

Y que por lo tanto pueden comunicarse por nombre:

```bash
ping 172.18.0.2
```

### Comunicación por nombre

Y ahora ya si, si intentamos hacer ping por nombre de contenedor, ¡FUNCIONA!

```bash
ping lemon-apache
```

## Conectar contenedores a múltiples redes

Pero espera ¿Qué pasa si quiero que un contenedor esté en múltiples redes al mismo tiempo? Pues eso es totalmente posible.

```bash
docker network connect bridge lemon-web
```

Y ahora si intentamos volver a comunicarnos, en este caso por IP con alguno de la red bridge, ¡FUNCIONA!

```bash
ping 172.17.0.3
```


# Ver que está en ambas redes

Como el nombre del contenedor sigue siendo único, podemos verificar que efectivamente está en ambas redes:

```bash
docker network inspect bridge

docker network inspect lemoncode-net
```

## Port Mapping

Como has podido ver, Docker lo que hace es crear una red interna para que los contenedores puedan comunicarse entre sí. Pero ¿Qué pasa si quiero que un contenedor sea accesible desde fuera de Docker? Aquí es donde entra el port mapping.

### Mapeo básico de puertos

Hasta ahora lo hemos hecho varias veces, pero ahora que sabes un poquito más de networking tiene todo más sentido.

Como nuestros contenedores están en una red aislada, no son accesibles desde fuera de Docker por defecto. Para hacerlos accesibles, necesitamos mapear puertos del host a puertos del contenedor.

```bash
# Mapear puerto 9090 del host al puerto 80 del contenedor
docker run -d -p 9090:80 nginx
```

Ahora puedes acceder al servidor en `http://localhost:9090`.### 🔓 Demo 8: Abriendo la puerta principal


### Usar EXPOSE en Dockerfile

# Creando un contenedor con puerta al mundo exterior

El comando EXPOSE en un Dockerfile documenta los puertos que usa la aplicación:

```dockerfile
FROM nginx
EXPOSE 80
EXPOSE 443
```

Pero simplemente hace eso, documentar. No mapea los puertos automáticamente. Lo que sí podemos hacer gracias a esta documentación es de forma automática mapear los puertos expuestos usando el flag `-P` o `--publish-all` al ejecutar el contenedor.

```bash
docker run -d -P nginx-custom
```

o bien:

```bash
docker run -d --publish-all nginx-custom

Y luego puedes ver qué puertos se han mapeado automáticamente usando:

```bash
docker inspect nginx-custom
```

También puedes verlo con `docker port`:

```bash
docker port lemon-web
```

## Red Host

Ahora que ya hemos jugado un rato con la red bridge y las redes personalizadas, vamos a ver otro tipo de red que es la red host.

Este tipo de red es un poco especial porque el contenedor no tiene su propia red aislada, sino que comparte la red del host. Esto significa que el contenedor puede usar directamente los puertos del host sin necesidad de mapearlos.

Para usarlo lo único que debes hacer es usar el flag `--network host` al crear el contenedor:

```bash
docker run -dit --network host --name web-host nginx
```


### Crear un contenedor sin red

Por último tenemos la red no red 😶. Esta hace que el contenedor esté totalmente aislado del mundo exterior.

```bash
docker run -dit --network none --name no-net-alpine alpine ash
```

Puedes comprobar que no tiene ninguna interfaz de red activa:

```bash
docker exec no-net-alpine ip link show
```

## Eliminar redes

Para eliminar una red personalizada que ya no necesites, usa el comando `docker network rm` seguido del nombre de la red:

```bash
docker network rm mi-red
```


# Limpiar redes no utilizadas (sin contenedores conectados)

También puedes limpiar de un plumazo todas las redes que no estés usando con:

```bash
docker network prune
```

También puedes desconectar contenedores de una red específica antes de eliminarla:

```bash
docker network disconnect lemoncode-net lemon-web
```


## ⭐ Bonus: extensión ngrok para Docker Desktop

Si usas Docker Desktop, puedes aprovechar la extensión de ngrok para exponer tus contenedores al mundo exterior de forma segura y sencilla. Esto es útil cuando quieres compartir tu trabajo con alguien sin necesidad de configurar puertos o redes complicadas.




## 🎉 ¡Felicidades, eres oficialmente un ninja de redes!

En esta épica aventura de networking has aprendido a:

- 🕵️ **Espiar redes disponibles** como un verdadero detective de Docker
- 🌉 **Dominar la red bridge** (y entender por qué es básica)
- 🏙️ **Crear barrios VIP** donde los contenedores se conocen por nombre
- 🚪 **Abrir puertas al mundo exterior** con port mapping como un portero profesional
- 🏠 **Mudarte con tus contenedores** usando la red host
- 🏝️ **Crear ermitaños digitales** con contenedores sin red
- 🧹 **Limpiar como Marie Kondo** para mantener Docker organizado


Ahora ya no eres solo alguien que ejecuta contenedores. ¡Eres el arquitecto de redes, el casamentero de contenedores, el ninja del networking! 🥷

En la siguiente clase seguiremos escalando en el mundo de Docker. Mientras tanto, ¡practica conectando contenedores como si fueras el Cupido de la tecnología! 💘

Happy networking! {🍋}