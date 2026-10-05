# 🎨 Azure Static Web Apps

## ¿Qué es Azure Static Web Apps?

Es un servicio **PaaS** ideal para desplegar aplicaciones web **estáticas** (sin lógica de servidor). Perfectamente preparado para frameworks como **Angular, React, Vue.js**, etc.

Características:
- ⚡ **Despliegue automático** desde GitHub
- 🚀 **CI/CD integrado** con GitHub Actions
- 🌍 **CDN global** para máximo rendimiento
- 📊 **Hosting de APIs** opcional
- 🔒 **HTTPS automático**

En este ejemplo, desplegaremos el **frontal de Tour of Heroes** (Angular) en Azure Static Web Apps.

## 📋 Requisitos previos

Necesitas un **fork** del repositorio de Tour of Heroes Angular:
👉 [Haz un fork aquí](https://github.com/0GiS0/tour-of-heroes-angular)

## 📝 Paso 1: Configurar variables de entorno

**En Linux/macOS:**
```bash
# Static Web App variables
WEB_APP_NAME="tour-of-heroes-web-$RANDOM"
GITHUB_USER_NAME="0gis0"
```

**En Windows PowerShell:**
```pwsh
# Static Web App variables
$WEB_APP_NAME="tour-of-heroes-web-$RANDOM"
$GITHUB_USER_NAME="<YOUR-GITHUB-USER-NAME>"
```

## 🚀 Paso 2: Crear Azure Static Web Apps

Ejecuta este comando para crear y conectar tu aplicación con GitHub:

**En Linux/macOS:**
```bash
az staticwebapp create \
--name $WEB_APP_NAME \
--resource-group $RESOURCE_GROUP \
--source https://github.com/$GITHUB_USER_NAME/tour-of-heroes-angular \
--location "westeurope" \
--branch main \
--app-location "/" \
--output-location "dist/angular-tour-of-heroes/browser" \
--login-with-github
```

**En Windows PowerShell:**
```pwsh
az staticwebapp create `
--name $WEB_APP_NAME `
--resource-group $RESOURCE_GROUP `
--source https://github.com/$GITHUB_USER_NAME/tour-of-heroes-angular `
--location "westeurope" `
--branch main `
--app-location "/" `
--output-location "dist/angular-tour-of-heroes" `
--login-with-github
```

**Nota:** Usamos `westeurope` porque Azure Static Web Apps no está disponible en `uksouth`.

## ✅ Verificar el despliegue

Se habrá creado automáticamente un **workflow de GitHub Actions** en tu repositorio que desplegará la aplicación.

Puedes ver el progreso en GitHub:

<img src="../images/Workflow de GitHub Actions para desplegar el frontal de tour of heroes.png" width="800">

Obtén la URL de tu aplicación con:

**En Linux/macOS:**
```bash
WEBAPP_URL=$(az staticwebapp show \
--name $WEB_APP_NAME \
--resource-group $RESOURCE_GROUP \
--query "defaultHostname" \
--output tsv)

echo "✅ Static Web App deployed!"
echo "📍 URL: https://$WEBAPP_URL"
```

**En Windows PowerShell:**
```pwsh
$WEBAPP_URL=$(az staticwebapp show `
--name $WEB_APP_NAME `
--resource-group $RESOURCE_GROUP `
--query "defaultHostname" `
--output tsv)

echo "✅ Static Web App deployed!"
echo "📍 URL: https://$WEBAPP_URL"
```

## ⚙️ Paso 3: Configurar la conexión a la API

La aplicación está desplegada, pero aún no apunta a tu API. Necesitas modificar el workflow de GitHub Actions para pasar la URL de tu API.

Abre el workflow en GitHub y modifica el paso **Build And Deploy** con lo siguiente:

```yaml
      - name: Build And Deploy
        id: builddeploy
        uses: Azure/static-web-apps-deploy@v1
        with:
          azure_static_web_apps_api_token: ${{ secrets.AZURE_STATIC_WEB_APPS_API_TOKEN_WONDERFUL_BAY_0AF2E3F03 }}
          repo_token: ${{ secrets.GITHUB_TOKEN }}
          action: "upload"
          app_build_command: API_URL=${{ secrets.API_URL}} npm run build-with-api-url
          app_location: "/"
          api_location: ""
          output_location: "dist/angular-tour-of-heroes/browser"
```

Importante! El flujo que crea Static Web Apps se apoya en Node 18 pero nuestra app usa Node 20 por lo que también es necesario añadir como variable
```yaml
      - name: Build And Deploy
        id: builddeploy
        uses: Azure/static-web-apps-deploy@v1
        env:
          NODE_VERSION: 20
```

el YAML final quedaría así:

```yaml
name: Azure Static Web Apps CI/CD

on:
  push:
    branches:
      - main
  pull_request:
    types: [opened, synchronize, reopened, closed]
    branches:
      - main

jobs:
  build_and_deploy_job:
    if: github.event_name == 'push' || (github.event_name == 'pull_request' && github.event.action != 'closed')
    runs-on: ubuntu-latest
    name: Build and Deploy Job
    steps:
      - uses: actions/checkout@v3
        with:
          submodules: true
          lfs: false
      - name: Build And Deploy
        id: builddeploy
        uses: Azure/static-web-apps-deploy@v1
        env:
          NODE_VERSION: 20 # 🆕 Nuevo incluido por mi
        with:
          azure_static_web_apps_api_token: ${{ secrets.AZURE_STATIC_WEB_APPS_API_TOKEN_GENTLE_BAY_033E22103 }}
          repo_token: ${{ secrets.GITHUB_TOKEN }} # Used for Github integrations (i.e. PR comments)
          action: 'upload'
          ###### Repository/Build Configurations - These values can be configured to match your app requirements. ######
          # For more information regarding Static Web App workflow configurations, please visit: https://aka.ms/swaworkflowconfig
          app_location: '/' # App source code path
          api_location: '' # Api source code path - optional
          output_location: 'dist/angular-tour-of-heroes/browser' # Built app content directory - optional
          app_build_command: API_URL=${{ secrets.API_URL}} npm run build-with-api-url
          ###### End of Repository/Build Configurations ######

  close_pull_request_job:
    if: github.event_name == 'pull_request' && github.event.action == 'closed'
    runs-on: ubuntu-latest
    name: Close Pull Request Job
    steps:
      - name: Close Pull Request
        id: closepullrequest
        uses: Azure/static-web-apps-deploy@v1
        with:
          azure_static_web_apps_api_token: ${{ secrets.AZURE_STATIC_WEB_APPS_API_TOKEN_GENTLE_BAY_033E22103 }}
          action: 'close'

```


### ¿Qué cambió?

Solo añadimos la propiedad `app_build_command` que:
- 📝 Ejecuta `npm run build-with-api-url` en tu package.json
- 🔗 Inyecta la variable de entorno `API_URL` desde los secretos de GitHub

### 🔐 Configurar los secretos de GitHub

Necesitas añadir un secreto en tu repositorio con la URL de la API:

1. Ve a **Settings** → **Secrets and variables** → **Actions**
2. Crea un secreto llamado `API_URL` con el valor de tu API (ej: `https://tour-of-heroes-api-xxxxx.azurewebsites.net`)

⚠️ **Importante:** 
- No copies el token `AZURE_STATIC_WEB_APPS_API_TOKEN_WONDERFUL_BAY_0AF2E3F03`, es único para tu servicio
- Solo añade la propiedad `app_build_command`
- Asegúrate de tener el secreto `API_URL` configurado

## 🎉 ¡Listo!

Ya tienes **Tour of Heroes** completamente desplegado en Azure con:
- ✅ Base de datos en Azure SQL
- ✅ API REST en Azure App Service
- ✅ Frontend en Azure Static Web Apps

## 🧹 Eliminar todos los recursos

Si quieres eliminar todo lo creado para evitar costes innecesarios:

```bash
az group delete --name $RESOURCE_GROUP --yes --no-wait
```

Esto eliminará todos los recursos del grupo de recursos.

---

**Happy coding!** 🥸