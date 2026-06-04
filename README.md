
# Trabajo Final - BtrFS

## Alumna:
Jimena Camila Morales

## Materia:
Administración de sistemas avanzadas.

## Descripción del proyecto
Este proyecto explora las funcionalidades avanzadas del sistema de archivos **BtrFS** mediante un laboratorio práctico en Ubuntu Desktop 24.04.  

Se enfoca en:

- Configuración de BtrFS sobre múltiples dispositivos.
- Creación y gestión de subvolúmenes.
- Implementación de cuotas de almacenamiento.
- Creación y restauración de snapshots mediante Copy-on-Write.
- Automatización del ciclo de vida de snapshots con scripts.
- Monitoreo del uso real del sistema de archivos.
- Comparación entre BtrFS y LVM.

## Entorno de pruebas
- Ubuntu Desktop 24.04 en VirtualBox.
- 4 discos virtuales de 1 GB cada uno (`sdb` a `sde`).
- Git y GitHub para control de versiones y documentación.

## Estructura del repositorio
- `docs/` → Documentación paso a paso del proyecto.
- `scripts/` → Scripts de automatización y monitoreo.
- `capturas/` → Evidencia visual del proceso.
- `reportes/` → Resultados generados por los scripts.
- `recursos/` → Bibliografía y referencias utilizadas.

## Objetivo final
Demostrar el funcionamiento de BtrFS como solución moderna de almacenamiento y comparar su eficiencia y flexibilidad frente a LVM, con herramientas de automatización y monitoreo incluidas.
