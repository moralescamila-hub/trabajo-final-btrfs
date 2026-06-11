
# Trabajo Final - BtrFS

## Alumna

**Morales Jimena Camila**

## Materia

**Administración de Sistemas Avanzadas**

## Descripción

Este proyecto tiene como objetivo explorar las principales funcionalidades del sistema de archivos **BtrFS** mediante la implementación de un laboratorio práctico sobre Ubuntu Desktop 24.04.

Durante el desarrollo se analizaron características avanzadas como:

* Filesystems BtrFS sobre múltiples dispositivos.
* Administración de subvolúmenes.
* Configuración de cuotas (qgroups).
* Creación y restauración de snapshots mediante Copy-on-Write (CoW).
* Automatización del ciclo de vida de snapshots.
* Replicación mediante `btrfs send` y `btrfs receive`.
* Monitoreo y observabilidad del filesystem.
* Comparación entre snapshots BtrFS y snapshots LVM.

---

## Objetivos

* Instalar y configurar BtrFS.
* Implementar un entorno multidevice.
* Crear y administrar subvolúmenes.
* Configurar cuotas de almacenamiento.
* Demostrar la recuperación de datos mediante snapshots.
* Automatizar tareas administrativas mediante scripting.
* Implementar mecanismos de monitoreo y observabilidad.
* Comparar el comportamiento de BtrFS con LVM.

---

## Entorno de Pruebas

| Componente                      | Configuración              |
| ------------------------------- | -------------------------- |
| Sistema Operativo               | Ubuntu Desktop 24.04 LTS   |
| Virtualización                  | VirtualBox                 |
| Discos para BtrFS               | 4 discos virtuales de 1 GB |
| Sistema de Control de Versiones | Git                        |
| Plataforma de publicación       | GitHub                     |

---

## Estructura del Repositorio

```text
trabajo-final-btrfs/
│
├── docs/         # Documentación técnica
├── scripts/      # Automatización y monitoreo
├── capturas/     # Evidencias visuales
├── reportes/     # Logs y reportes generados
```

---

## Documentación

| Documento                      | Descripción                    |
| ------------------------------ | ------------------------------ |
| 01-introduccion.md             | Contexto y objetivos           |
| 02-entorno-de-pruebas.md       | Infraestructura utilizada      |
| 03-instalacion-btrfs.md        | Instalación y configuración    |
| 04-subvolumenes-y-cuotas.md    | Administración de subvolúmenes |
| 05-snapshots-y-restauracion.md | Snapshots y recuperación       |
| 06-automatizacion.md           | Automatización con scripting   |
| 07-monitoreo.md                | Observabilidad y monitoreo     |
| 08-comparacion-con-lvm.md      | Comparación con LVM            |
| 09-conclusiones.md             | Conclusión final               |
| 10-ejemplo.md                  | Ejemplo de la domostración     |
---

## Scripts incluidos

### snapshot-manager.sh

Automatiza el ciclo de vida de snapshots:

* Creación de snapshots readonly.
* Política de retención configurable.
* Eliminación automática de snapshots antiguos.
* Replicación mediante `btrfs send` y `btrfs receive`.
* Generación de logs.

### btrfs-monitor.sh

Implementa observabilidad del filesystem:

* Uso interno de Data y Metadata.
* Estado de dispositivos.
* Información de cuotas y subvolúmenes.
* Captura de estadísticas desde `/proc/diskstats`.
* Detección de errores.
* Generación de reportes y logs.

---

## Resultados obtenidos

Durante las pruebas se logró:

* Implementar un filesystem BtrFS sobre múltiples dispositivos.
* Configurar cuotas y subvolúmenes independientes.
* Crear snapshots instantáneos mediante CoW.
* Recuperar información eliminada utilizando snapshots.
* Automatizar tareas administrativas.
* Implementar monitoreo y generación de reportes.
* Analizar diferencias entre BtrFS y LVM.

---

## Licencia

Este repositorio se distribuye bajo licencia MIT.

