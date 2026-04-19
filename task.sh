# !/bin/bash

BACKUP_DIR="/home/user/backups"
mkdir -p "$BACKUP_DIR"

if mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --databases ShopDB --result-file="$BACKUP_DIR/ShopDBReserve.sql"; then
  echo "$(date): SUCCESS Production reserve copy created successfully"
else
  echo "$(date): ERROR Production reserve copying is failed!" >&2
fi

if mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --databases ShopDB --no-create-info --result-file="$BACKUP_DIR/ShopDBDevelopment.sql"; then
  echo "$(date): SUCCESS ShopDBDevelopment.sql was created."
else
  echo "$(date): ERROR Failed to transfer data to ShopDBDevelopment.sql" >&2
fi