#!/bin/bash

# ==========================================================
# Alumna: Morales Jimena Camila
# Materia: Administración de Sistemas Avanzadas
# Consigna: Adición de Scripting (Automatización del ciclo de vida de Snapshots):
#           ◦ En lugar de hacer btrfs subvolume snapshot a mano y sacar una captura de pantalla,
#             diseña una herramienta de nivel de producción. Puede incluir lógica para que el script
#             borre automáticamente los snapshots de más de X días o que envíe los deltas a otro directorio
#             usando btrfs send y btrfs receive.
# Nombre del script: snapshot-manager.sh
# Automatización del ciclo de vida de snapshots BtrFS
# ==========================================================

set -euo pipefail

# ----------------------------
# Configuración
# ----------------------------

MOUNT_POINT="/mnt/btrfs"
SOURCE_SUBVOL="$MOUNT_POINT/proyectos"
SNAPSHOT_DIR="$MOUNT_POINT/snapshots"
BACKUP_DIR="$MOUNT_POINT/backups"
RETENTION_DAYS=7

LOGFILE="./reportes/logs/snapshot-manager.log"
mkdir -p "$(dirname "$LOGFILE")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"
}

# ----------------------------
# Validaciones
# ----------------------------

log "Iniciando snapshot-manager"

if ! mountpoint -q "$MOUNT_POINT"; then
    log "ERROR: $MOUNT_POINT no está montado"
    exit 1
fi

for dir in "$SOURCE_SUBVOL" "$SNAPSHOT_DIR" "$BACKUP_DIR"; do
    if [ ! -d "$dir" ]; then
        log "ERROR: Directorio inexistente: $dir"
        exit 1
    fi
done

# ----------------------------
# Crear snapshot
# ----------------------------

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
SNAPSHOT_NAME="proyectos-$TIMESTAMP"
SNAPSHOT_PATH="$SNAPSHOT_DIR/$SNAPSHOT_NAME"

log "Creando snapshot readonly: $SNAPSHOT_NAME"
sudo btrfs subvolume snapshot -r "$SOURCE_SUBVOL" "$SNAPSHOT_PATH"
log "Snapshot creado correctamente"

# ----------------------------
# Retención: eliminar snapshots antiguos
# ----------------------------

log "Buscando snapshots con más de $RETENTION_DAYS días"
find "$SNAPSHOT_DIR" -maxdepth 1 -type d -name "proyectos-*" -mtime +"$RETENTION_DAYS" | while read -r SNAP; do
    SNAP_COUNT=$(find "$SNAPSHOT_DIR" -maxdepth 1 -type d -name "proyectos-*" | wc -l)
    if [ "$SNAP_COUNT" -le 1 ]; then
        log "Se conserva al menos un snapshot. No se eliminan más snapshots."
        break
    fi
    log "Eliminando snapshot antiguo: $SNAP"
    sudo btrfs subvolume delete "$SNAP"
done

# ----------------------------
# Replicación con send/receive
# ----------------------------

# Buscar último snapshot previo para envío incremental
LAST_SNAPSHOT=$(find "$BACKUP_DIR" -maxdepth 1 -type d -name "proyectos-*" | sort | tail -n1 || true)

if [ -z "$LAST_SNAPSHOT" ]; then
    log "Primer backup: envío completo del snapshot"
    sudo btrfs send "$SNAPSHOT_PATH" | sudo btrfs receive "$BACKUP_DIR"
else
    log "Envío incremental basado en: $(basename "$LAST_SNAPSHOT")"
    sudo btrfs send -p "$LAST_SNAPSHOT" "$SNAPSHOT_PATH" | sudo btrfs receive "$BACKUP_DIR"
fi

log "Replicación completada correctamente"
log "Proceso finalizado"
