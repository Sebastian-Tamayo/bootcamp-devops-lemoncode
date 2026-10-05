import express from 'express';
import { fileURLToPath } from 'url';
import { dirname } from 'path';

// 📦 Importar el módulo Express
// 🚀 Crear una instancia de la aplicación Express
const app = express();

// Obtener __dirname en módulos ES6
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// 📁 Servir archivos estáticos desde la carpeta 'public'
app.use(express.static(__dirname + '/public'));

// 🏠 Ruta GET para la página principal
app.get('/', function (req, res) {
  // 📄 Enviar el archivo index.html como respuesta
  res.sendFile(__dirname + '/index.html')
});

// 🔌 Iniciar el servidor en el puerto 3000
const PORT = 3000;
app.listen(PORT, function () {
  // ✅ Mensaje de confirmación en consola con URL clicable
  console.log(`\n✅ Aplicación ejecutándose en http://localhost:${PORT}\n`);
});