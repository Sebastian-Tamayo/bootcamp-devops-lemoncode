# 💾 Crear máquina virtual Ubuntu para la base de datos (PostgreSQL)

Esta es una versión alternativa que utiliza **Ubuntu** con **PostgreSQL** en lugar de Windows con SQL Server. Es una opción más económica y sencilla de configurar.

## 📋 Variables de entorno necesarias

```bash
# 🐘 PostgreSQL VM en Azure (Ubuntu)
DB_VM_NAME="db-vm"
DB_VM_IMAGE="Ubuntu2204"
DB_VM_ADMIN_USERNAME="dbadmin"
DB_VM_NSG_NAME="db-vm-nsg"
VM_SIZE="Standard_DS1_v2"

# 🔐 Credenciales de PostgreSQL (las usaremos dentro de la VM)
POSTGRES_USER="heroesadmin"
POSTGRES_PASSWORD="Heroes@2024#"
POSTGRES_DB="heroes"
```

o si estás en Windows:

```pwsh
# 🐘 PostgreSQL VM en Azure (Ubuntu)
$DB_VM_NAME="db-vm"
$DB_VM_IMAGE="Ubuntu2204"
$DB_VM_ADMIN_USERNAME="dbadmin"
$DB_VM_NSG_NAME="db-vm-nsg"
$VM_SIZE="Standard_B2as_v2"

# 🔐 Credenciales de PostgreSQL (las usaremos dentro de la VM)
$POSTGRES_USER="heroesadmin"
$POSTGRES_PASSWORD="Heroes@2024#"
$POSTGRES_DB="heroes"
```

## 🖥️ Crear la máquina virtual

```bash
echo -e "🖥️ Creando máquina virtual Ubuntu para base de datos $DB_VM_NAME"

az vm create \
--resource-group $RESOURCE_GROUP \
--name $DB_VM_NAME \
--image $DB_VM_IMAGE \
--admin-username $DB_VM_ADMIN_USERNAME \
--generate-ssh-keys \
--vnet-name $VNET_NAME \
--subnet $DB_SUBNET_NAME \
--size $VM_SIZE \
--nsg $DB_VM_NSG_NAME

echo -e "✅ Máquina virtual creada"
```

o si estás en Windows:

```pwsh
echo "🖥️ Creando máquina virtual Ubuntu para base de datos $DB_VM_NAME"

az vm create `
--resource-group $RESOURCE_GROUP `
--name $DB_VM_NAME `
--image $DB_VM_IMAGE `
--admin-username $DB_VM_ADMIN_USERNAME `
--generate-ssh-keys `
--vnet-name $VNET_NAME `
--subnet $DB_SUBNET_NAME `
--size $VM_SIZE `
--nsg $DB_VM_NSG_NAME `
--public-ip-address ""

echo "✅ Máquina virtual creada"
```

> 💡 **Nota**: Usamos `--generate-ssh-keys` para crear automáticamente las claves SSH y `--public-ip-address ""` para no asignar IP pública (más seguro).

## 🔒 Crear regla de seguridad de red para PostgreSQL

Para poder acceder a PostgreSQL desde la API:

```bash
echo -e "🔒 Creando regla de seguridad para PostgreSQL puerto 5432"

az network nsg rule create \
--resource-group $RESOURCE_GROUP \
--nsg-name $DB_VM_NSG_NAME \
--name AllowPostgreSQL \
--priority 1001 \
--destination-port-ranges 5432 \
--protocol Tcp \
--source-address-prefixes $API_SUBNET_ADDRESS_PREFIX \
--direction Inbound

echo -e "✅ Regla de seguridad creada"
```

o si estás en Windows:

```pwsh
echo "🔒 Creando regla de seguridad para PostgreSQL puerto 5432"

az network nsg rule create `
--resource-group $RESOURCE_GROUP `
--nsg-name $DB_VM_NSG_NAME `
--name AllowPostgreSQL `
--priority 1001 `
--destination-port-ranges 5432 `
--protocol Tcp `
--source-address-prefixes $API_SUBNET_ADDRESS_PREFIX `
--direction Inbound

echo "✅ Regla de seguridad creada"
```

## 🐘 Instalar y configurar PostgreSQL

Utilizamos `az vm run-command` para ejecutar el script de instalación de PostgreSQL en la VM sin necesidad de conectarnos por SSH. El script acepta como parámetro la subred desde la que se permitirán conexiones (la subred de la API):

```bash
echo -e "🐘 Instalando y configurando PostgreSQL..."

az vm run-command invoke \
--resource-group $RESOURCE_GROUP \
--name $DB_VM_NAME \
--command-id RunShellScript \
--scripts @04-cloud/azure/iaas/scripts/setup-postgresql.sh \
--parameters $API_SUBNET_ADDRESS_PREFIX

echo -e "✅ PostgreSQL instalado y configurado"
```

o si estás en Windows:

```pwsh
echo "🐘 Instalando y configurando PostgreSQL..."

az vm run-command invoke `
--resource-group $RESOURCE_GROUP `
--name $DB_VM_NAME `
--command-id RunShellScript `
--scripts @04-cloud/azure/iaas/scripts/setup-postgresql.sh `
--parameters $API_SUBNET_ADDRESS_PREFIX

echo "✅ PostgreSQL instalado y configurado"
```

El script [setup-postgresql.sh](../scripts/setup-postgresql.sh) realiza automáticamente:
- ✅ Instalación de PostgreSQL
- ✅ Creación del usuario `heroesadmin` y base de datos `heroes`
- ✅ Configuración para aceptar conexiones remotas desde la subred de la API (pasada como parámetro)
- ✅ Configuración del firewall UFW

### 🔍 Verificar la instalación (opcional)

Si quieres comprobar que PostgreSQL se instaló correctamente:

```bash
az vm run-command invoke \
--resource-group $RESOURCE_GROUP \
--name $DB_VM_NAME \
--command-id RunShellScript \
--scripts "sudo systemctl status postgresql && sudo -u postgres psql -c '\l'"
```

## 🔗 Obtener la IP privada de la base de datos

```bash
DB_PRIVATE_IP=$(az vm show \
--resource-group $RESOURCE_GROUP \
--name $DB_VM_NAME \
--show-details \
--query "privateIps" -o tsv)

echo -e "🔗 IP privada de la base de datos: $DB_PRIVATE_IP"
```

o si estás en Windows:

```pwsh
$DB_PRIVATE_IP = az vm show `
--resource-group $RESOURCE_GROUP `
--name $DB_VM_NAME `
--show-details `
--query "privateIps" -o tsv

echo "🔗 IP privada de la base de datos: $DB_PRIVATE_IP"
```

## 🔗 Cadena de conexión para la API

La cadena de conexión para PostgreSQL desde tu API sería:

```
Host=$DB_PRIVATE_IP;Port=5432;Database=heroes;Username=heroesadmin;Password=Heroes@2024#
```

O en formato URI:

```
postgresql://heroesadmin:Heroes@2024#@$DB_PRIVATE_IP:5432/heroes
```

---

## 📊 Resumen de la arquitectura

```
┌─────────────────────────────────────────────────────────┐
│                    Virtual Network                      │
│                                                         │
│  ┌────────────────────┐    ┌────────────────────┐       │
│  │   API Subnet       │    │   DB Subnet        │       │
│  │   192.168.2.0/24   │    │   192.168.1.0/24   │       │
│  │                    │    │                    │       │
│  │  ┌──────────────┐  │    │  ┌──────────────┐  │       │
│  │  │   API VM     │  │───▶│  │   DB VM      │  │       │
│  │  │              │  │    │  │   Ubuntu     │  │       │
│  │  └──────────────┘  │    │  │   PostgreSQL │  │       │
│  │                    │    │  │   :5432      │  │       │
│  └────────────────────┘    │  └──────────────┘  │       │
│                            │   (Sin IP pública) │       │
│                            └────────────────────┘       │
└─────────────────────────────────────────────────────────┘
```

---

Ahora que ya tienes la base de datos creada con PostgreSQL, necesitamos una API que interactúe con ella. Puedes continuar en el siguiente [paso](../02-api-vm/README.md) 🚀.
