# Instalación de BtrFS

En esta sección se documenta la instalación y verificación de BtrFS en la máquina virtual Ubuntu Desktop 24.04.

## Verificación de la instalación:

BtrFS ya venía instalado en la máquina virtual. Para confirmar si esta instalado, se puede ejecutar:

```bash
btrfs version
```

Resultado obtenido:

```text
btrfs-progs v6.6.3
```
![Verificación de BtrFS](../capturas/btrfs-version.png)

La salida confirma que BtrFS se encuentra instalado y disponible para su utilización en el sistema.


## Instalación en caso de no estar presente en el sistema:

En caso de que BtrFS no este instalado, podría instalarse con los siguientes comandos:

```bash
sudo apt update
sudo apt install btrfs-progs
```

Una vez finalizada la instalación, se puede volver a ejecutar el comando `btrfs version` para verificar que el paquete fue instalado correctamente.
