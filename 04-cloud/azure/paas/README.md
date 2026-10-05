## 🚀 Desplegando Tour of Heroes en servicios PaaS de Azure

### 📋 Requisitos previos

Antes de empezar a montar servicios PaaS necesitas tener:

- ☁️ **Cuenta de Azure**: Si no tienes una, puedes crear una [gratuita aquí](https://azure.microsoft.com/es-es/free/)
- 🖥️ **Azure CLI**: Necesitas tener instalado el [CLI de Azure](https://docs.microsoft.com/es-es/cli/azure/install-azure-cli?view=azure-cli-latest) en tu máquina local

### 🔑 Paso 1: Autenticarse en Azure

Ejecuta el siguiente comando para iniciar sesión en tu cuenta de Azure:

```bash
az login --use-device-code
```

### 📝 Paso 2: Configurar variables de entorno

Para facilitar la creación de recursos, te recomendamos que definas estas variables en tu terminal:

**En Linux/macOS:**
```bash
# General variables
RESOURCE_GROUP="tour-of-heroes-paas"
LOCATION="spaincentral"
```

**En Windows PowerShell:**
```pwsh
# General variables
$RESOURCE_GROUP="tour-of-heroes-paas"
$LOCATION="spaincentral"
```

### 📦 Paso 3: Crear un grupo de recursos

Un **grupo de recursos** es un contenedor lógico en el que se despliegan y administran todos tus recursos de Azure.

Crea uno ejecutando:

```bash
az group create --name $RESOURCE_GROUP --location $LOCATION
```

### 🗄️ Paso 4: Crear la base de datos

Ahora que tienes los requisitos básicos listos, vamos a crear la base de datos. 

Continúa con el siguiente paso en este [README](./01-sql-database/README.md) 📖