#!/bin/bash

# Configuration
BACKUP_DIR="/backups"
LOG_DIR="/var/log/app"
MAX_BACKUPS=7
MAX_LOG_AGE=30

# Create backup of the application
create_backup() {
    DATE=$(date +%Y%m%d_%H%M%S)
    tar -czf "$BACKUP_DIR/backup_$DATE.tar.gz" /app
    
    # Remove old backups
    ls -1t $BACKUP_DIR/backup_*.tar.gz | tail -n +$((MAX_BACKUPS + 1)) | xargs -r rm
}

# Rotate logs
rotate_logs() {
    find $LOG_DIR -type f -name "*.log" -mtime +$MAX_LOG_AGE -exec rm {} \;
    for log in $LOG_DIR/*.log; do
        if [ -f "$log" ]; then
            mv "$log" "$log.$(date +%Y%m%d)"
            gzip "$log.$(date +%Y%m%d)"
        fi
    done
}

# Main execution
create_backup
rotate_logs 