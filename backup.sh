#!/bin/bash

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="/home/mika/DOCKERBACKUPS"
DB_NAME="cars"
DB_USER="mika"
DB_CONTAINER="testipossu"  

if [ ! -d "$BACKUP_DIR" ]; then
    echo "Error: Backup directory $BACKUP_DIR does not exist."
    exit 1
fi

sudo docker exec -u postgres $DB_CONTAINER pg_dump -U $DB_USER -d $DB_NAME > $BACKUP_DIR/${DB_NAME}_backup_$TIMESTAMP.sql

if [ $? -eq 0 ]; then
    echo "Backup for database $DB_NAME completed successfully at $TIMESTAMP."
else
    echo "Backup for database $DB_NAME failed at $TIMESTAMP."
fi

ls -lt "$BACKUP_DIR"
