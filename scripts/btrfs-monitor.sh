#!/bin/bash
# ==================================================
# Alumna: Morales Jimena Camila
# Materia: Administración de Sistemas Avanzadas
# Consigna: Adición de Monitoreo (Observabilidad del Sistema de Archivos):
#          ◦ Btrfs gestiona el espacio de una forma muy particular (asigna chunks de Data y Metadata por separado),
#            lo que suele confundir a los administradores novatos cuando df -h dice una cosa pero el disco está lleno.
#            Monitorear esto con herramientas como btrfs filesystem df, combinadas con scripts que capturen datos
#            de /proc/diskstats o alertas de error cuando un disco del RAID simula una falla.
# Nombre del script: btrfs-monitor.sh
# Observabilidad del filesystem BtrFS
# ==================================================
set -euo pipefail
MOUNT_POINT="/mnt/btrfs"
LOGFILE="./reportes/logs/btrfs-monitor.log"
REPORT_FILE="./reportes/estado-btrfs.txt"
mkdir -p ./reportes/logs
log() {
echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"
}
# ------------------------------------
# Validación
# ------------------------------------
if ! mountpoint -q "$MOUNT_POINT"; then
log "ERROR: $MOUNT_POINT no está montado"
exit 1
fi
log "Iniciando monitoreo"
{
echo "========================================"
echo "REPORTE BTRFS"
echo "Fecha: $(date)"
echo "========================================"
echo
echo "=== USO DEL FILESYSTEM ==="
sudo btrfs filesystem df "$MOUNT_POINT"
echo
echo "=== DISPOSITIVOS DEL POOL ==="
sudo btrfs filesystem show "$MOUNT_POINT"
echo
echo "=== CUOTAS Y SUBVOLÚMENES ==="
sudo btrfs qgroup show "$MOUNT_POINT"
echo
echo "=== ESTADÍSTICAS DE DISPOSITIVOS ==="
sudo btrfs device stats "$MOUNT_POINT"
echo
echo "=== /proc/diskstats ==="
cat /proc/diskstats

} > "$REPORT_FILE"
# ------------------------------------
# Verificación de errores
# ------------------------------------
ERRORS=$(sudo btrfs device stats "$MOUNT_POINT" | grep -v " 0$" || true)
if [ -n "$ERRORS" ]; then
log "ALERTA: Se detectaron errores en dispositivos del pool BtrFS"
echo
echo "Errores encontrados:"
echo "$ERRORS"
else
log "No se detectaron errores en dispositivos"
fi
# ------------------------------------
# Verificación de Metadata
# ------------------------------------
METADATA=$(sudo btrfs filesystem df "$MOUNT_POINT" | grep Metadata)
log "Estado de Metadata:"
log "$METADATA"
log "Reporte generado en $REPORT_FILE"
log "Monitoreo finalizado"
