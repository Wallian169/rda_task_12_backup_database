#!/bin/bash

if mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --databases ShopDB --result-file=ShopDBReserve.sql; then
  echo "$(date): SUCCESS Production reserve copy created successfully"
else
  echo "$(date): ERROR Production reserve copying is failed!" >&2
fi
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < ShopDBReserve.sql

if mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --databases ShopDB --no-create-info --result-file=ShopDBDevelopment.sql; then
  echo "$(date): SUCCESS ShopDBDevelopment.sql was created."
else
  echo "$(date): ERROR Failed to transfer data to ShopDBDevelopment.sql" >&2
fi
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < "ShopDBDevelopment.sql"