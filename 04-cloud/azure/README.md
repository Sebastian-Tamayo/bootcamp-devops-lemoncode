# ☁️ Azure - Bootcamp DevOps Lemoncode

Bienvenido a la sección de Azure del bootcamp DevOps. En esta sección aprenderás dos de los modelos de servicio más importantes en la nube: **IaaS** (Infrastructure as a Service) y **PaaS** (Platform as a Service).

## 📚 Contenido del Módulo

### 🏢 Clase 1: Infrastructure as a Service (IaaS)

**Directorio:** `./iaas/`

En esta clase aprenderás a desplegar una aplicación completa de Tour of Heroes utilizando **máquinas virtuales** en Azure. Este enfoque te proporciona control total sobre la infraestructura.

#### ¿Qué es IaaS?
IaaS es un modelo de computación en la nube donde **tú eres responsable de gestionar** las máquinas virtuales, redes, almacenamiento y sistemas operativos. Azure proporciona la infraestructura subyacente.

#### Componentes que aprenderás:

1. **Redes Virtuales** 🌐
   - Crear redes virtuales con múltiples subredes
   - Configurar direccionamiento IP
   - [Ver clase completa](./iaas/00-vnet/README.md)

2. **Máquina Virtual de Base de Datos** 💾
   - Desplegar SQL Server en una VM
   - Configurar backups automáticos
   - Crear reglas de seguridad
   - [Ver clase completa](./iaas/01-db-vm/README.md)

3. **Máquina Virtual de API** 🔌
   - Desplegar .NET Core API en Linux
   - Configurar Nginx como proxy inverso
   - Crear servicios systemd
   - [Ver clase completa](./iaas/02-api-vm/README.md)

4. **Máquina Virtual de Frontend** 🎨
   - Desplegar Angular en IIS
   - Configurar aplicaciones web
   - Habilitar puertos y firewall
   - [Ver clase completa](./iaas/03-frontend-vm/README.md)

5. **Balanceador de Carga** ⚖️
   - Distribuir tráfico entre múltiples VMs
   - Sondas de salud
   - Reglas de balanceo
   - [Ver clase completa](./iaas/04-load-balancer/README.md)

#### Ventajas de IaaS:
✅ Control total sobre la infraestructura
✅ Escalabilidad flexible
✅ Pagas solo por lo que usas
✅ Compatibilidad con aplicaciones legacy
✅ Seguridad configurable

#### Desventajas de IaaS:
❌ Mayor responsabilidad operativa
❌ Gestión compleja de infraestructura
❌ Requiere conocimientos avanzados
❌ Mantenimiento continuo

---

### 🚀 Clase 2: Platform as a Service (PaaS)

**Directorio:** `./paas/`

En esta clase aprenderás a desplegar la misma aplicación Tour of Heroes, pero utilizando **servicios completamente gestionados** por Azure. Este enfoque reduce la complejidad operativa.

#### ¿Qué es PaaS?
PaaS es un modelo de computación en la nube donde **Azure gestiona** la infraestructura, sistemas operativos y middleware. Tú solo te enfocas en tu código y datos.

#### Componentes que aprenderás:

1. **Azure SQL Database** 💾
   - Servicio de base de datos completamente gestionado
   - Backups automáticos incluidos
   - Escalado automático
   - [Ver clase](./paas/)

2. **Azure App Service** 🔌
   - Hostear aplicaciones .NET Core
   - CI/CD integrado
   - Escalado automático
   - [Ver clase](./paas/)

3. **Static Web Apps** 🎨
   - Desplegar aplicaciones Angular
   - CDN global incluido
   - HTTPS automático
   - [Ver clase](./paas/)

4. **Otros Servicios PaaS**
   - API Management
   - Function Apps
   - Logic Apps
   - [Ver clase](./paas/)

#### Ventajas de PaaS:
✅ Menor responsabilidad operativa
✅ Escalado automático
✅ Mantenimiento automático
✅ Mejor enfoque en el desarrollo
✅ Costo más predecible
✅ Menos seguridad operativa

#### Desventajas de PaaS:
❌ Menos control sobre la infraestructura
❌ Posibles limitaciones de plataforma
❌ Vendor lock-in
❌ Menos flexibilidad en configuración

---

## 🔄 Comparativa IaaS vs PaaS

| Aspecto | IaaS | PaaS |
|--------|------|------|
| **Control** | Total | Limitado |
| **Responsabilidad** | Alta | Baja |
| **Complejidad** | Alta | Baja |
| **Escalado** | Manual | Automático |
| **Mantenimiento** | Tú | Azure |
| **Costo** | Variable | Predecible |
| **Flexibilidad** | Alta | Media |
| **Curva de aprendizaje** | Empinada | Suave |

---

## 🎯 Decisión: ¿Cuándo usar IaaS vs PaaS?

### Usa **IaaS** cuando:
- Necesitas control total sobre la infraestructura
- Tienes aplicaciones legacy complejas
- Requieres configuraciones muy específicas
- Necesitas máxima flexibilidad

### Usa **PaaS** cuando:
- Quieres enfocarte solo en el código
- Tu aplicación es moderna y compatible
- Buscas reducir costos operativos
- Necesitas escalado automático

---

## 📖 Cómo aprovechar este módulo

1. **Comienza con IaaS** 🏢
   - Entiende los conceptos fundamentales
   - Aprende a gestionar infraestructura
   - Experimenta con máquinas virtuales

2. **Continúa con PaaS** 🚀
   - Compara la complejidad
   - Aprecia la simplicidad de servicios gestionados
   - Entiende cuándo usar cada uno

3. **Practica el despliegue** 🔧
   - Despliega la aplicación en ambos modelos
   - Compara los resultados
   - Experimenta con configuraciones

---

## 🛠️ Requisitos Previos

- Cuenta activa en Azure
- Azure CLI instalado (lo tienes como parte del Dev Container de este repo, ya instalado y listo para usar)
- Conocimientos básicos de:
  - Redes
  - Máquinas virtuales
  - Bases de datos
  - Aplicaciones web

---


¡Que disfrutes aprendiendo sobre Azure! ☁️
