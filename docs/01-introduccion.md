# Introducción

## Contexto

Los sistemas de archivos modernos no solo deben almacenar información, sino también proporcionar mecanismos que permitan garantizar la integridad de los datos, optimizar el uso del almacenamiento y facilitar las tareas de administración.

BtrFS (B-tree File System) es un sistema de archivos de nueva generación desarrollado para Linux que incorpora funcionalidades avanzadas tradicionalmente disponibles únicamente mediante la combinación de múltiples herramientas o capas de almacenamiento.

Entre sus principales características se destacan:

* Soporte nativo para múltiples dispositivos.
* Snapshots instantáneos mediante Copy-on-Write (CoW).
* Subvolúmenes independientes.
* Compresión transparente.
* Cuotas de almacenamiento.
* Integridad de datos mediante checksums.
* Replicación nativa utilizando `btrfs send` y `btrfs receive`.

Estas capacidades convierten a BtrFS en una alternativa atractiva para entornos donde se requiere flexibilidad, protección de datos y facilidad de administración.

## Objetivos del trabajo

El objetivo principal de este trabajo consiste en explorar las funcionalidades más relevantes de BtrFS mediante la implementación de un entorno práctico de laboratorio.

Para ello se desarrollan las siguientes actividades:

* Instalación y verificación de BtrFS.
* Creación de un filesystem BtrFS sobre múltiples dispositivos.
* Configuración de subvolúmenes y cuotas.
* Creación y administración de snapshots.
* Recuperación de información a partir de snapshots.
* Comparación del consumo de espacio con snapshots de LVM.
* Automatización del ciclo de vida de snapshots mediante scripting.
* Implementación de mecanismos de monitoreo y observabilidad.

## Alcance

Las pruebas fueron realizadas en un entorno virtualizado basado en Ubuntu Desktop 24.04 utilizando múltiples discos virtuales dedicados exclusivamente a la experimentación con BtrFS.

El enfoque del trabajo se centra en demostrar el funcionamiento práctico de las principales funcionalidades del sistema de archivos y analizar sus ventajas para tareas de administración, respaldo y recuperación de información.

## Metodología

La metodología utilizada consistió en la construcción progresiva de un entorno de pruebas donde se configuraron dispositivos de almacenamiento, subvolúmenes, cuotas y snapshots.

Posteriormente se desarrollaron herramientas de automatización y monitoreo con el objetivo de simular escenarios similares a los encontrados en entornos productivos.

Finalmente se realizaron pruebas de recuperación de datos y comparaciones con snapshots implementados mediante LVM para evaluar diferencias de funcionamiento y consumo de espacio.

## Estructura del documento

El trabajo se encuentra organizado en las siguientes secciones:

1. Introducción.
2. Entorno de pruebas.
3. Instalación de BtrFS.
4. Subvolúmenes y cuotas.
5. Snapshots y restauración.
6. Automatización del ciclo de vida de snapshots.
7. Monitoreo y observabilidad.
8. Comparación con snapshots de LVM.
9. Conclusiones.
10. Ejemplo para la exposición.

