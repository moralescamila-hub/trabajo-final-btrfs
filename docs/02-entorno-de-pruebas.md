# Entorno de Pruebas

## Introducción

Con el objetivo de evaluar las funcionalidades de BtrFS en un entorno controlado, se implementó un laboratorio virtual que permitió realizar pruebas de administración, snapshots, recuperación de información, automatización y monitoreo sin afectar sistemas productivos.

## Plataforma utilizada

Las pruebas fueron realizadas sobre una máquina virtual con las siguientes características:

| Componente                | Configuración                       |
| ------------------------- | ----------------------------------- |
| Sistema Operativo         | Ubuntu Desktop 24.04 LTS            |
| Arquitectura              | x86_64                              |
| Sistema de Virtualización | VirtualBox                          |
| Almacenamiento para BtrFS | 4 discos virtuales de 1 GB cada uno |

## Configuración de almacenamiento

Para la implementación del filesystem BtrFS se agregaron cuatro discos virtuales independientes.

Los dispositivos fueron detectados por el sistema como:

| Dispositivo | Tamaño |
| ----------- | ------ |
| /dev/sdb    | 1 GB   |
| /dev/sdc    | 1 GB   |
| /dev/sdd    | 1 GB   |
| /dev/sde    | 1 GB   |

Inicialmente se creó el filesystem sobre el dispositivo `/dev/sdb` y posteriormente se incorporaron los discos restantes utilizando la funcionalidad multidevice de BtrFS.

## Verificación de dispositivos

La detección de los discos fue verificada mediante:

```bash
lsblk
```

![Discos](../capturas/discos-virtuales.png)

La salida permitió confirmar la disponibilidad de los dispositivos antes de iniciar la configuración del filesystem.

## Arquitectura implementada

La arquitectura utilizada durante el trabajo puede representarse de la siguiente manera:

```text
BtrFS Filesystem
│
├── /dev/sdb (1 GB)
├── /dev/sdc (1 GB)
├── /dev/sdd (1 GB)
└── /dev/sde (1 GB)
```

Todos los dispositivos forman parte de un único filesystem administrado por BtrFS.

Posteriormente se ejecutó un proceso de balanceo para redistribuir los datos y metadatos entre los discos disponibles.

## Justificación del entorno

La utilización de múltiples dispositivos permite demostrar una de las capacidades más importantes de BtrFS: la administración de almacenamiento distribuido dentro de un único filesystem.

Además, este entorno facilita la realización de pruebas relacionadas con:

* Expansión de capacidad.
* Administración de espacio.
* Snapshots.
* Replicación mediante send/receive.
* Monitoreo de dispositivos.
* Recuperación de información.

Estas características resultan especialmente relevantes en escenarios donde se requiere flexibilidad y crecimiento progresivo del almacenamiento.

## Consideraciones

El entorno fue diseñado para la práctica y demostración.

Por este motivo se utilizaron discos virtuales de tamaño reducido (1 GB cada uno), suficientes para evidenciar el funcionamiento de las características analizadas sin requerir una gran cantidad de recursos físicos.

