# Ejemplo de exposición – Guía del proyecto

Este documento sirve como guía para la demostración en vivo del proyecto. Los comandos se ejecutan en orden y se explican durante la exposición.

---

## 1. Estado inicial del sistema

Se muestra el contenido del subvolumen principal:

```bash
ls /mnt/btrfs/proyectos
```

Se verifica el uso del subvolumen:

```bash
sudo btrfs filesystem du -s /mnt/btrfs/proyectos
```

### Aclaración

En este subvolumen ya existen snapshots creados anteriormente durante la práctica del proyecto. Por este motivo, parte del espacio aparece como compartido (Shared), ya que el subvolumen y los snapshots utilizan los mismos bloques mediante Copy-on-Write.

### Explicación

Antes de realizar el snapshot se muestra el estado inicial de los datos.

---

## 2. Creación del snapshot

Para la creación del snapshot se utilizará el script `snapshot-manager.sh`.

Se ejecuta el script:

```bash
./scripts/snapshot-manager.sh
```

Esto permite demostrar:

* Automatización
* Snapshot readonly
* Política de retención
* Replicación mediante `btrfs send` y `btrfs receive`
* Logging

Se visualizan los logs del proceso:

```bash
cat reportes/logs/snapshot-manager.log
```

También se muestran los snapshots generados:

```bash
ls /mnt/btrfs/snapshots
```

### Explicación

El script automatiza la creación de snapshots, el control de versiones y la replicación de datos.

---

## 3. Verificación del snapshot (Copy-on-Write)

Se comprueba el uso de espacio del snapshot:

```bash
sudo btrfs filesystem du -s /mnt/btrfs/snapshots/proyectos-20260609-221747
```

### Aclaración

Se debe seleccionar el snapshot más reciente generado por el script.

### Explicación

El snapshot comparte bloques con el subvolumen original gracias al mecanismo Copy-on-Write, por lo que inicialmente no duplica los datos.

---

## 4. Simulación de pérdida de datos

Se modifica un archivo:

```bash
echo "Información incorrecta" | sudo tee /mnt/btrfs/proyectos/archivo.txt
```

Se verifica el cambio:

```bash
cat /mnt/btrfs/proyectos/archivo.txt
```

Se elimina el archivo:

```bash
sudo rm /mnt/btrfs/proyectos/archivo.txt
```

Se verifica la eliminación:

```bash
ls /mnt/btrfs/proyectos
```

### Explicación

Se simula un error humano o una pérdida accidental de información.

---

## 5. Restauración desde snapshot

Se listan los snapshots disponibles:

```bash
ls /mnt/btrfs/snapshots
```

Se restaura el archivo desde el snapshot:

```bash
sudo cp /mnt/btrfs/snapshots/<snapshot-mas-reciente>/archivo.txt /mnt/btrfs/proyectos/
```

### Aclaración

Se debe utilizar el snapshot más reciente generado por el script.

Se verifica la restauración:

```bash
cat /mnt/btrfs/proyectos/archivo.txt
```

### Explicación

Se recupera el archivo desde el snapshot sin necesidad de restaurar todo el sistema.

Esto permite recuperar información específica de forma rápida y con un impacto mínimo sobre el resto de los datos.

---

## 6. Monitoreo del filesystem

Se ejecuta el script de monitoreo:

```bash
sudo ./scripts/btrfs-monitor.sh
```

Se visualiza el reporte generado:

```bash
cat reportes/estado-btrfs.txt
```

### Explicación

Se muestra información sobre el uso del filesystem, dispositivos, cuotas y estado general de BtrFS.

BtrFS administra datos y metadatos por separado, por lo que herramientas tradicionales como df -h no siempre reflejan completamente el estado real del filesystem.

---

## 7. Replicación de snapshots

Se verifican los backups generados:

```bash
ls /mnt/btrfs/backups
```

### Explicación

Además del snapshot local, se genera una copia utilizando `btrfs send` y `btrfs receive`. En este proyecto los snapshots son replicados automáticamente al subvolumen `backups`.

---

## Cierre de la demostración

Durante esta práctica se demostró:

* Uso de BtrFS sobre múltiples dispositivos
* Creación de subvolúmenes
* Gestión de cuotas
* Snapshots automáticos
* Restauración de datos
* Monitoreo del filesystem
* Replicación de snapshots

Esto muestra cómo BtrFS permite administrar datos de forma eficiente, segura y flexible.
