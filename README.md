# Bootcamp DevOps Lemoncode {🍋}


pass docker
sebas3212
docker3212!


¡Hola lemoncoders! 👋🏻🍋

En este repositorio encontrarás todo el material necesario para el **[Bootcamp DevOps de Lemoncode](https://lemoncode.net/bootcamp-devops#bootcamp-devops/inicio)**. Cada uno de los profesores se ha encargado de crear el contenido de cada una de las sesiones, por lo que encontrarás una estructura de carpetas y ficheros que se corresponderán con cada una de las clases del bootcamp.

## 🎯 Objetivos del Bootcamp

Este bootcamp está diseñado para proporcionar una formación completa en DevOps, cubriendo desde los fundamentos de Linux hasta tecnologías avanzadas de orquestación, CI/CD, cloud computing e infraestructura como código.

## 🧑🏽‍💻👩🏼‍💻 Entorno de Desarrollo

Este repositorio incluye un **Dev Container** configurado con todas las herramientas necesarias para el bootcamp:

- **Azure CLI** - Para trabajar con Azure
- **.NET 8.0** - Para aplicaciones .NET
- **kubectl** - Para orquestación de Kubernetes
- **GitHub CLI** - Para integración con GitHub
- **Node.js LTS** - Para aplicaciones JavaScript/TypeScript
- **Docker in Docker** - Para trabajar con contenedores
- Y muchas más herramientas esenciales

### 💻 Cómo usar el Dev Container

1. Abre el proyecto en VS Code
2. Instala la extensión [Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
3. Presiona `Ctrl+Shift+P` y selecciona "Dev Containers: Reopen in Container"
4. ¡Todo listo para empezar!

## 📚 Contenido del Bootcamp

### [00 - Fundamentos de Linux](./00-fundamentos-linux/README.md)
**Duración**: Módulo 1
**Tecnologías**: Linux, Bash, CLI

Aprende los fundamentos esenciales de Linux:
- Sistema operativo Linux y distribuciones
- Sistema jerárquico de ficheros
- Comandos básicos de CLI y navegación
- Gestión de usuarios, grupos y permisos
- Bash scripting y automatización
- Configuración de red y conectividad SSH
- Uso de herramientas como `curl`, `grep`, `find`

**🎯 Ejercicios prácticos incluidos**

---

### [01 - Contenedores](./01-contenedores/README.md)
**Duración**: Módulo 2
**Tecnologías**: Docker, Docker Compose, Registries

Domina la tecnología de contenedores:
- **Día I**: Introducción a Docker, comandos básicos, gestión de contenedores
- **Día II**: Trabajo con imágenes, registries, Docker Hub
- **Día III**: Creación de Dockerfiles personalizados
- **Día IV**: Volumes, bind mounts y persistencia de datos
- **Día V**: Redes en Docker, comunicación entre contenedores
- **Día VI**: Docker Compose para aplicaciones multi-contenedor

**🏆 Incluye Lemoncode Challenge**: Proyectos completos con stack Node.js y .NET

---

### [02 - Orquestación de contenedores](./02-orquestacion/README.md)
**Duración**: Módulo 2
**Tecnologías**: Kubernetes, Minikube, KinD, kubeadm

Aprende orquestación de contenedores con Kubernetes:
- Conceptos fundamentales: Pods, Services, Deployments
- ReplicaSets y gestión de réplicas
- ConfigMaps y Secrets
- Volúmenes y persistencia
- Ingress Controllers para exposición de servicios
- Namespaces y gestión de recursos

**🔧 Entornos soportados**:
- Minikube (desarrollo local)
- KinD (Kubernetes in Docker)
- Vagrant con kubeadm (entorno completo)

**📋 Ejercicios prácticos**:
- Monolito en memoria
- Monolito con base de datos
- Aplicaciones distribuidas con Ingress

---

### [03 - CI/CD Herramientas](./03-cd/README.md)
**Duración**: Módulo 3
**Tecnologías**: Jenkins, GitLab CI/CD, GitHub Actions

Implementa pipelines de integración y despliegue continuo:

#### Jenkins
- Configuración y administración
- Pipelines declarativas
- Librerías compartidas
- Integración con Docker

#### GitLab CI/CD
- GitLab Runners
- Pipelines avanzadas
- Container Registry
- Despliegue automatizado

#### GitHub Actions
- Workflows y eventos
- Actions del marketplace
- Secrets y variables
- Integración con cloud providers

**🎯 Ejercicios obligatorios**: Pipelines para aplicaciones Java + Gradle

---

### [04 - Cloud Computing](./04-cloud/README.md)
**Duración**: Módulo 4
**Tecnologías**: Azure, AWS, AKS, EKS

Despliega en la nube:
- **Azure**: Azure Kubernetes Service (AKS)
- **AWS**: Elastic Kubernetes Service (EKS)
- Gestión de clusters en la nube
- Integración con servicios nativos
- Monitoreo y logging

**📚 Incluye guías paso a paso** para crear tu primer cluster

---

### [05 - Infraestructura como código](./05-iac/README.md)
**Duración**: Módulo 5
**Tecnologías**: Terraform, Terraform Cloud

Automatiza la gestión de infraestructura:
- Conceptos de Infrastructure as Code
- Sintaxis de Terraform (HCL)
- Providers y recursos
- State management
- Terraform Cloud y backends remotos
- Módulos reutilizables
- Best practices y patrones

---

### [06 - Observabilidad](./06-monitoring/README.md)
**Duración**: Módulo 6
**Tecnologías**: Prometheus, Grafana, Logging

Implementa monitoreo y observabilidad:
- Métricas con Prometheus
- Visualización con Grafana
- Alerting y notificaciones
- Logging centralizado
- Tracing distribuido

## 🛠️ Herramientas y Tecnologías

### Contenedores y Orquestación
- Docker & Docker Compose
- Kubernetes
- Minikube, KinD
- Helm (para gestión de paquetes)

### CI/CD
- Jenkins
- GitLab CI/CD
- GitHub Actions
- Docker Registry

### Cloud Providers
- Microsoft Azure (AKS)
- Amazon AWS (EKS)
- Google Cloud Platform

### Infrastructure as Code
- Terraform
- Terraform Cloud
- ARM Templates / CloudFormation

### Monitoreo
- Prometheus
- Grafana
- ELK Stack
- Jaeger

## 📋 Prerrequisitos

### Básicos
- Conocimientos básicos de línea de comandos
- Familiaridad con Git
- Conceptos básicos de redes

### Software necesario
- **VS Code** con extensión Dev Containers (recomendado)
- **Docker Desktop** (para entorno local)
- **Git** para control de versiones

### Para ejercicios específicos
- **Minikube** o **KinD** para Kubernetes local
- **VirtualBox** y **Vagrant** (ejercicios avanzados)
- Cuenta en **GitHub** para CI/CD
- Cuenta en **Azure** o **AWS** para módulos de cloud

## 🏃‍♂️ Cómo empezar

1. **Clona el repositorio**:
   ```bash
   git clone https://github.com/Lemoncode/bootcamp-devops-lemoncode.git
   cd bootcamp-devops-lemoncode
   ```

2. **Abre en VS Code con Dev Container** (recomendado):
   - Instala la extensión "Dev Containers"
   - Abre el proyecto en VS Code
   - Selecciona "Reopen in Container" cuando aparezca la notificación

3. **O configura tu entorno local**:
   - Instala Docker
   - Instala las herramientas específicas de cada módulo

4. **Sigue los módulos en orden**:
   - Cada módulo tiene su propio README con instrucciones detalladas
   - Los ejercicios están marcados como obligatorios u opcionales

## 📖 Estructura del Repositorio

```
bootcamp-devops-lemoncode/
├── .devcontainer/          # Configuración del entorno de desarrollo
├── 00-fundamentos-linux/   # Módulo 1: Linux y CLI
├── 01-contenedores/        # Módulo 2: Docker y contenedores
├── 02-orquestacion/        # Módulo 2: Kubernetes
├── 03-cd/                  # Módulo 3: CI/CD
├── 04-cloud/               # Módulo 4: Cloud Computing
├── 05-iac/                 # Módulo 5: Terraform
├── 06-monitoring/          # Módulo 6: Observabilidad
└── README.md              # Este archivo
```

## 🎓 Certificación

Para superar el bootcamp, deberás completar:
- **Ejercicios obligatorios** de cada módulo
- **Proyectos prácticos** específicos
- **Lemoncode Challenges** cuando estén disponibles

## 🤝 Contribuir

¿Encontraste un error o quieres mejorar el contenido?
1. Haz fork del repositorio
2. Crea una rama para tu feature
3. Envía un pull request

## 📞 Soporte

- **Documentación**: Cada módulo tiene su README detallado
- **Issues**: Usa el sistema de issues de GitHub para reportar problemas
- **Comunidad**: Únete a la comunidad de Lemoncode

## 🔗 Enlaces útiles

- [Bootcamp DevOps Lemoncode](https://lemoncode.net/bootcamp-devops#bootcamp-devops) - Información oficial
- [Documentación Docker](https://docs.docker.com/)
- [Documentación Kubernetes](https://kubernetes.io/docs/)
- [Terraform Documentation](https://terraform.io/docs/)

---

**¡Feliz aprendizaje! 🍋✨**