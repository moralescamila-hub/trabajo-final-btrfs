# Comparación entre Snapshots BtrFS y LVM

## Introducción

Tanto BtrFS como LVM ofrecen mecanismos para capturar el estado de un sistema de almacenamiento en un momento determinado mediante snapshots.

Sin embargo, ambos enfoques presentan diferencias significativas en cuanto a arquitectura, administración y utilización de espacio.

El objetivo de esta sección consiste en comparar ambas tecnologías y analizar su comportamiento frente a escenarios de recuperación de información.

## Snapshots en BtrFS

BtrFS implementa snapshots de manera nativa mediante la tecnología Copy-on-Write (CoW).

Cuando se crea un snapshot, no se realiza una copia completa de los datos existentes.

En su lugar, el snapshot comparte los mismos bloques del subvolumen original y únicamente se almacenan nuevos bloques cuando se producen modificaciones posteriores.

Esto permite:

* Creación prácticamente instantánea.
* Consumo mínimo de espacio inicial.
* Recuperación rápida de información.
* Administración integrada dentro del filesystem.

## Snapshots en LVM

LVM implementa snapshots a nivel de bloques.

Al crear un snapshot es necesario reservar espacio para almacenar las modificaciones futuras que se produzcan sobre el volumen original.

Por ejemplo:

```bash
sudo lvcreate -L 200M -s -n snap_proyectos /dev/vgdatos/lvdatos
```

En este caso se reserva un área de 200 MB destinada al snapshot.

A medida que el volumen original se modifica, LVM almacena las diferencias dentro de ese espacio reservado.

## Comparación funcional

| Característica                          | BtrFS               | LVM            |
| --------------------------------------- | ------------------- | -------------- |
| Nivel de operación                      | Sistema de archivos | Bloques        |
| Snapshots nativos                       | Sí                  | Sí             |
| Copy-on-Write                           | Sí                  | Sí             |
| Subvolúmenes                            | Sí                  | No             |
| Cuotas integradas                       | Sí                  | No             |
| Send / Receive                          | Sí                  | No             |
| Administración de archivos individuales | Sí                  | No             |
| Replicación incremental                 | Sí                  | No             |
| Espacio inicial requerido               | Mínimo              | Reserva previa |

## Comparación del uso de espacio

Durante las pruebas realizadas con BtrFS se observó el siguiente comportamiento:

```text
Total      Exclusive   Shared
150.00MiB      0.00B   150.00MiB
```

El resultado muestra que el snapshot comparte la totalidad de los bloques con el subvolumen original y no requiere espacio exclusivo inmediatamente después de su creación.

En contraste, un snapshot LVM requiere la reserva de espacio desde el momento de su creación.

Por ejemplo:

```text
LV           VG        Attr       LSize
lvdatos      vgdatos   -wi-ao---- 1.00g
snap_test    vgdatos   swi-a-s--- 200.00m
```

Aunque el snapshot aún no contenga cambios significativos, la reserva de espacio ya existe dentro del grupo de volúmenes.

## Recuperación de información

Ambas tecnologías permiten recuperar datos eliminados o modificados.

Sin embargo, BtrFS ofrece una ventaja adicional al trabajar directamente con subvolúmenes y archivos.

En el escenario desarrollado durante este trabajo fue posible restaurar un archivo individual copiándolo directamente desde el snapshot:

```bash
cp snapshot/archivo.txt proyectos/
```

En LVM normalmente resulta necesario montar el snapshot para acceder a su contenido, agregando pasos adicionales al proceso de recuperación.

## Ventajas observadas de BtrFS

Durante las pruebas realizadas se observaron las siguientes ventajas:

* Creación instantánea de snapshots.
* Menor consumo inicial de espacio.
* Administración integrada.
* Soporte nativo para subvolúmenes.
* Replicación incremental mediante send/receive.
* Recuperación sencilla de archivos individuales.

## Conclusión

Ambas tecnologías proporcionan mecanismos eficaces para preservar el estado de los datos y facilitar tareas de recuperación.

No obstante, BtrFS ofrece una integración más profunda entre snapshots, almacenamiento y administración del sistema de archivos, permitiendo implementar estrategias de respaldo y recuperación con menor complejidad operativa.

La utilización de Copy-on-Write y la posibilidad de compartir bloques entre snapshots convierten a BtrFS en una alternativa especialmente eficiente para entornos donde se requiere la generación frecuente de puntos de recuperación.

