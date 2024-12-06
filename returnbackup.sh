#!/bin/bash

read -p "Enter the name of the backup file (e.g., cars_backup_2024-12-05_12-00-00.sql): " BACKUP_FILENAME

BACKUP_DIR="/home/mika/DOCKERBACKUPS"
DOCKER_BACKUP_DIR="/BACKUPS"
HOST_BACKUP_FILE="$BACKUP_DIR/$BACKUP_FILENAME"
DOCKER_BACKUP_FILE="$DOCKER_BACKUP_DIR/$BACKUP_FILENAME"
DB_NAME="cars"
DB_USER="mika"
DB_CONTAINER="testipossu"

# Tarkistetaan, että varmuuskopiotiedosto on olemassa
if [ ! -f "$HOST_BACKUP_FILE" ]; then
    echo "Error: Backup file $BACKUP_FILE does not exist."
    exit 1
fi

# Varmistus, että käyttäjä on valmis jatkamaan
echo "WARNING: This will delete and recreate the database '$DB_NAME'."
read -p "Are you sure you want to continue? (yes/no): " CONFIRM
if [[ "$CONFIRM" != "yes" ]]; then
    echo "Operation canceled."
    exit 0
fi

# Poistetaan olemassa oleva tietokanta
echo "Deleting existing database: $DB_NAME"
sudo docker exec -i -u postgres $DB_CONTAINER psql -U $DB_USER -d postgres -c "DROP DATABASE IF EXISTS $DB_NAME;"

# Luodaan uusi tietokanta
echo "Re-creating database: $DB_NAME"
sudo docker exec -i -u postgres $DB_CONTAINER psql -U $DB_USER -d postgres -c "CREATE DATABASE $DB_NAME;"

# Palautetaan varmuuskopio
echo "Restoring database backup"
#sudo docker exec -i -u postgres $DB_CONTAINER psql -U $DB_USER -d $DB_NAME < "$BACKUP_FILE"
echo "Using backup file: $BACKUP_FILE"
sudo docker exec -i -u postgres $DB_CONTAINER bash -c "cat $DOCKER_BACKUP_FILE | psql -U $DB_USER -d $DB_NAME"

# Tarkistetaan palautuksen onnistuminen ja taulun olemassaolo
if [ $? -eq 0 ]; then
    echo "Restore for database $DB_NAME completed successfully."
    echo "Displaying the current state of the database $DB_NAME:"

    # Tarkistetaan, että taulu 'cars' on olemassa
    TABLE_EXISTS=$(sudo docker exec -i -u postgres $DB_CONTAINER psql -U $DB_USER -d $DB_NAME -t -c "SELECT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'cars');" | xargs)

    if [ "$TABLE_EXISTS" = "t" ]; then
        echo "Taulu 'cars' on palautettu onnistuneesti."
        sudo docker exec -i -u postgres $DB_CONTAINER psql -U $DB_USER -d $DB_NAME -c "SELECT * FROM cars;"
    else
        echo "Virhe: Taulu 'cars' ei ole palautettu oikein."
    fi
else
    echo "Restore for database $DB_NAME failed."
fi
