# Ejemplo de como enlazar un ConfigMap con un fichero a un volumen del pod

Para ello tenéis que crear el configmap:

```
kubectl create cm settings --from-file settings.json=setting.json
```

