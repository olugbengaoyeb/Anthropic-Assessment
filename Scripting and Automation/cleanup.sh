#!/usr/bin/env bash
set -euo pipefail

CONFIG_FILE="./config.conf"
LOG_FILE="./logs/cleanup.log"
DRY_RUN=true
REGION=""
DAYS_UNUSED=30

mkdir -p logs

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') [$1] $2" | tee -a "$LOG_FILE"
}

error_exit() {
  log "ERROR" "$1"
  exit 1
}

load_config() {
  [[ -f "$CONFIG_FILE" ]] || error_exit "Config file not found"
  # shellcheck disable=SC1090
  source "$CONFIG_FILE"
}

while getopts "c:r:d:n" opt; do
  case "$opt" in
    c) CONFIG_FILE="$OPTARG" ;;
    r) REGION="$OPTARG" ;;
    d) DAYS_UNUSED="$OPTARG" ;;
    n) DRY_RUN=false ;;
    *) error_exit "Invalid arguments" ;;
  esac
done

load_config
[[ -z "$REGION" ]] && error_exit "AWS region is required"

log "INFO" "Starting AWS cleanup in region $REGION"
log "INFO" "Dry-run mode: $DRY_RUN"
log "INFO" "Unused threshold: $DAYS_UNUSED days"

# ---------------------------
# Find stopped EC2 instances
# ---------------------------
STOPPED_INSTANCES=$(aws ec2 describe-instances \
  --region "$REGION" \
  --filters "Name=instance-state-name,Values=stopped" \
  --query "Reservations[].Instances[].InstanceId" \
  --output text)

for instance in $STOPPED_INSTANCES; do
  log "INFO" "Found stopped EC2 instance: $instance"
  if [[ "$DRY_RUN" == false ]]; then
    aws ec2 terminate-instances --instance-ids "$instance" --region "$REGION"
    log "INFO" "Terminated EC2 instance: $instance"
  fi
done

# ---------------------------
# Find unattached EBS volumes
# ---------------------------
VOLUMES=$(aws ec2 describe-volumes \
  --region "$REGION" \
  --filters "Name=status,Values=available" \
  --query "Volumes[].VolumeId" \
  --output text)

for volume in $VOLUMES; do
  log "INFO" "Found unattached EBS volume: $volume"
  if [[ "$DRY_RUN" == false ]]; then
    aws ec2 delete-volume --volume-id "$volume" --region "$REGION"
    log "INFO" "Deleted EBS volume: $volume"
  fi
done

log "INFO" "Cleanup completed successfully"
