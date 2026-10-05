# 🌐 Azure App Service

## ¿Qué es Azure App Service?

Es un servicio **PaaS** que te permite desplegar aplicaciones web y API REST de forma rápida y sencilla. Además ofrece:

- 📈 **Escalado automático** según la demanda
- 🔗 **Integración** con otros servicios de Azure (SQL Database, Cosmos DB, Key Vault, etc.)
- 🔐 **Seguridad** integrada
- 📊 **Monitoreo y logging** automático

En este ejemplo, vamos a crear una **API REST con ASP.NET Core** y desplegarla en Azure App Service.

## 📝 Paso 1: Configurar variables de entorno

**En Linux/macOS:**
```bash
# App Service variables
APP_SVC_PLAN_NAME="tour-of-heroes-plan"
WEB_API_NAME="tour-of-heroes-api-$RANDOM"
```

**En Windows PowerShell:**
```pwsh
# App Service variables
$APP_SVC_PLAN_NAME="tour-of-heroes-plan"
$WEB_API_NAME="tour-of-heroes-api-$RANDOM"
```

⚠️ **Nota importante:** Asegúrate de que el nombre de la web app es **único en Azure**.

## 📦 Paso 2: Crear el plan de App Service

Todas las aplicaciones web necesitan estar dentro de un **plan de App Service**. Este plan determina el tamaño de las máquinas virtuales que alojarán tu aplicación.

Ejecuta este comando:

**En Linux/macOS:**
```bash
echo "Creating App Service Plan..."

az appservice plan create \
--name $APP_SVC_PLAN_NAME \
--resource-group $RESOURCE_GROUP \
--location $LOCATION \
--sku S1
```

**En Windows PowerShell:**
```pwsh
echo "Creating App Service Plan..."

az appservice plan create `
--name $APP_SVC_PLAN_NAME `
--resource-group $RESOURCE_GROUP `
--location $LOCATION `
--sku S1
```

En este caso, usamos el plan **S1** que ofrece un buen equilibrio entre capacidad y coste.

## 🚀 Paso 3: Crear la web app para la API

Ahora que tienes el plan, crea la web app:

**En Linux/macOS:**
```bash
az webapp create \
--name $WEB_API_NAME \
--runtime "dotnet:9" \
--resource-group $RESOURCE_GROUP \
--plan $APP_SVC_PLAN_NAME
```

**En Windows PowerShell:**
```pwsh
az webapp create `
--name $WEB_API_NAME `
--runtime "dotnet:8" `
--resource-group $RESOURCE_GROUP `
--plan $APP_SVC_PLAN_NAME
```

## ⚙️ Paso 4: Configurar la conexión a la base de datos

Ahora configura la cadena de conexión a la base de datos y otras variables de entorno:

**En Linux/macOS:**
```bash
az webapp config connection-string set \
--name $WEB_API_NAME \
--resource-group $RESOURCE_GROUP \
--connection-string-type SQLAzure \
--settings "DefaultConnection=Server=tcp:$SQL_SERVER_NAME.database.windows.net,1433;Initial Catalog=heroes-db;Persist Security Info=False;User ID=$SQL_USER;Password=$SQL_PASSWORD;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

az webapp config appsettings set \
--name $WEB_API_NAME \
--resource-group $RESOURCE_GROUP \
--settings "OTEL_SERVICE_NAME=tour-of-heroes-api"
```

**En Windows PowerShell:**
```pwsh
az webapp config connection-string set `
--name $WEB_API_NAME `
--resource-group $RESOURCE_GROUP `
--connection-string-type SQLAzure `
--settings "DefaultConnection=Server=tcp:$SQL_SERVER_NAME.database.windows.net,1433;Initial Catalog=heroes-db;Persist Security Info=False;User ID=$SQL_USER;Password=$SQL_PASSWORD;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

az webapp config appsettings set `
--name $WEB_API_NAME `
--resource-group $RESOURCE_GROUP `
--settings "OTEL_SERVICE_NAME=tour-of-heroes-api"
```

Esto configura:
- 🔗 La cadena de conexión a Azure SQL Database
- 📊 El nombre del servicio para OpenTelemetry/Azure Monitor

## 🚀 Paso 5: Desplegar la API

Ahora toca desplegar el código. Sigue estos pasos:

**En Linux/macOS:**
```bash
echo "Cloning repository..."
git clone https://github.com/0GiS0/tour-of-heroes-dotnet-api.git
cd tour-of-heroes-dotnet-api

echo "Building and publishing..."
cd src
dotnet publish tour-of-heroes-api.csproj -o ./publish

echo "Deploying to Azure..."
cd publish
zip -r site.zip *

az webapp deployment source config-zip \
--src site.zip \
--resource-group $RESOURCE_GROUP \
--name $WEB_API_NAME


```

**En Windows PowerShell:**
```pwsh
echo "Cloning repository..."
git clone https://github.com/0GiS0/tour-of-heroes-dotnet-api.git
cd tour-of-heroes-dotnet-api

echo "Publishing..."
cd src
dotnet publish tour-of-heroes-api.csproj -o ./publish

echo "Deploying to Azure..."
cd publish
Compress-Archive -Path * -DestinationPath site.zip

az webapp deployment source config-zip `
--src site.zip `
--resource-group $RESOURCE_GROUP `
--name $WEB_API_NAME
```

## 💻 Alternativa: Usar VS Code Extension

También puedes gestionar todo esto con la **extensión de Azure App Service para Visual Studio Code**.

<img src="../images/Extension%20de%20Azure%20App%20Service.png"/>

## ✅ Verificar el despliegue

Una vez completado, verifica que todo funcionó correctamente:

```bash
echo "✅ API deployed successfully!"
echo "📍 API URL: https://$WEB_API_NAME.azurewebsites.net/api/hero"
```

## ➡️ Siguiente paso

Ahora toca desplegar el frontal. Continúa en este [README](../03-static-web-apps/README.md) 📖
