## Prerequisitos

Para poder ejecutar los siguientes comando necesitas tener instalado Azure CLI como se comenta en el [README](../README.md) principal.

Una vez lo tengas, utiliza estas variables de entorno para configurar las tuyas propias si fuera necesario:

```bash
RESOURCE_GROUP="bootcamp-lemoncode$RANDOM"
AKS_NAME="lemoncode-cluster$RANDOM"
LOCATION="spaincentral"
```

o si estás en Windows:

```pwsh
$RESOURCE_GROUP="bootcamp-lemoncode"
$AKS_NAME="lemoncode-cluster"
$LOCATION="spaincentral"
```

Con estas estamos diciendo cuál sería el nombre del grupo de recursos donde voy a almacenar mi nuevo clúster de Kubernetes, el nombre que le voy a dar al mismo, así como la localización donde se desplegará este. Con estas ya puedo crear primeramente el grupo de recursos:

```bash
az group create -n ${RESOURCE_GROUP} -l ${LOCATION}
```

Ahora que ya tienes un sitio donde guardar recursos, puedes crear tu clúster de Kubernetes en él:

```bash
az aks create -g ${RESOURCE_GROUP} \
-n ${AKS_NAME} \
--node-count 1 \
--generate-ssh-keys
```

> ⚠️ **Nota importante**: Si es la primera vez que creas un clúster de AKS en tu suscripción, es posible que necesites registrar el proveedor de recursos `Microsoft.ContainerService`. Puedes hacerlo con el siguiente comando:
>
> ```bash
> az provider register --namespace Microsoft.ContainerService
> ```
>
> Puedes comprobar el estado del registro con:
>
> ```bash
> az provider show --namespace Microsoft.ContainerService --query "registrationState" -o tsv
> ```
>
> Espera hasta que el estado sea `Registered` antes de continuar con la creación del clúster.

Como puedes ver, crear un clúster de AKS es extremadamente sencillo. Obviamente se pueden añadir más opciones durante su creación, pero oye, para ser tu primer clúster es más que suficiente 😉

Una vez que finalice la creación lo siguiente que necesitas es instalar `kubectl` si no lo tienes todavía. Azure CLI también puede ayudarte en esta tarea usando este comando:

```bash
az aks install-cli
```
Una vez finalice podrás recuperar el contexto para poder interactuar con este clúster:

```bash
az aks get-credentials -g ${RESOURCE_GROUP} -n ${AKS_NAME} --overwrite-existing
```

Para comprobar que puedes conectarte al mismo puedes hacerlo a partir de este momento con `kubectl` de la forma habitual:

```bash
kubectl get nodes
```

¡Hurra 🎉! Ya tienes un clúster totalmente funcional en el que desplegar tus contenedores. Para esta clase vamos a utilizar mi Tour Of Heroes para ver qué pinta tiene en este tipo de entornos. 

Todos los manifiestos que necesitas para el mismo puedes encontrarlos en la carpeta [manifests](manifests/) dentro de esta misma unidad. Para poder aplicar todos los archivos del tirón basta con ejecutar este comando:

```bash
kubectl create namespace tour-of-heroes
kubectl apply -f 04-cloud/00-aks/01-mi-primer-aks/manifests --recursive --namespace tour-of-heroes
```

Una vez que se hayan desplegado todos los recursos, puedes comprobar que todo está funcionando correctamente con estos comandos:

```bash
kubectl get all --namespace tour-of-heroes
```

Si no han terminado de desplegarse puedes esperarlos con el comando `watch`:

```bash
watch kubectl get all --namespace tour-of-heroes
```

Como estás en un entorno cloud, puedes exponer el servicio de forma pública para poder acceder a él desde cualquier sitio. Si te fijas de los servicios para la API y el frontal estos son del tipo `LoadBalancer`. Si quieres recuperar las IPs públicas de los mismos puedes hacerlo con estos comandos:

```bash
API_IP=$(kubectl get service tour-of-heroes-api --namespace tour-of-heroes -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
WEB_IP=$(kubectl get service tour-of-heroes-web --namespace tour-of-heroes -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
```
Para probar el acceso a la API puedes hacerlo con este comando:

```bash
echo http://${API_IP}/api/hero
```

Para probar el acceso a la web puedes hacerlo con este otro:

```bash
echo http://${WEB_IP}
```

Esta no está apuntando a la API correcta pero puedes modificar la variable de entorno `API_URL` para que apunte a la correcta:

```bash
kubectl set env deployment/tour-of-heroes-web --namespace tour-of-heroes API_URL=http://${API_IP}/api/hero
```

Como ves, no hay ningún héroe en la base de datos, pero puedes usar el archivo heroes.http que te he dejado como parte de esta unidad. Recuerda reemplazar la IP por la que te ha dado el servicio de la API.

Si después de lanzarlo vuelves a ejecutar el comando para recuperar los héroes, verás que ya tienes algunos en la base de datos. ¡Hurra 🎉!