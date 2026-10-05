# Frontend - Aplicación de TODOs en PHP

Interfaz web en PHP que consume la API REST del backend.

## 📋 Descripción

Frontend construido con **PHP + HTML5 + CSS3** que consume la API del backend para mostrar una lista de TODOs.

## 📁 Estructura

- **index.php** - Código PHP principal que renderiza el HTML y consume la API
- **styles.css** - Estilos CSS (diseño responsivo)
- **app.js** - JavaScript adicional (si es necesario, puede ser opcional)

## 🎨 Características

- 📊 Mostrar estadísticas (total, completadas, pendientes)
- 🔄 Botón para actualizar la lista (recarga la página)
- 📱 Diseño responsivo (mobile-friendly)
- 🎯 Interfaz moderna con gradientes
- ⚠️ Manejo de errores visual
- 💫 Animaciones suaves
- **✅ Renderizado en servidor (PHP)**

## 🚀 Requisitos

- PHP 7.0 o superior
- Backend accesible en `http://localhost:8001/api.php` (host)
- Frontend expuesto en `http://localhost:8000`

## 🔧 Configuración

La URL de la API está configurada y autodetecta entorno en `index.php`:

```php
// Por defecto dentro de Docker:
$api_url = 'http://host.docker.internal:8001/api.php';

// Si corre fuera de Docker (PHP built-in server):
if (php_sapi_name() === 'cli-server' || strpos($_SERVER['HTTP_HOST'], 'localhost') === 0) {
	$api_url = 'http://localhost:8001/api.php';
}
```

`host.docker.internal` permite que el contenedor acceda al backend expuesto por el host en macOS y Windows. En Linux puede requerir configuración adicional.

## 📝 Flujo de la aplicación

1. Al acceder a `index.php`, PHP realiza una petición GET al backend
2. Se procesan los datos recibidos en servidor
3. Se renderiza el HTML con los datos
4. El usuario ve la lista de TODOs
5. Al hacer clic en "Actualizar", se recarga la página y se repite el proceso

## 🎯 Ventajas de usar PHP para el frontend

- ✅ Renderizado en servidor (SSR)
- ✅ No requiere JavaScript en cliente
- ✅ SEO friendly (contenido generado en servidor)
- ✅ Comparte la imagen base `php:8.2-apache` con el backend
- ✅ Reutiliza las mismas capas de Docker

## 📱 Responsive Design

La aplicación se adapta a diferentes tamaños de pantalla:
- Desktop: Grid de 3 columnas para estadísticas
- Mobile: Grid de 1 columna para mejor legibilidad

## 🐛 Debugging

Para ver información de depuración, añade esto en PHP:
```php
ini_set('display_errors', 1);
error_reporting(E_ALL);
```

---

Para iniciar la aplicación, ver el README principal.
