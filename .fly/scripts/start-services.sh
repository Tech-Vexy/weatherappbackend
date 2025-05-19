#!/bin/bash

# Enhanced startup script for Fly.io deployment
set -e

echo "Starting services..."

# Ensure logs directory exists and is writable
mkdir -p /var/log/nginx
mkdir -p /var/log/php
chmod -R 777 /var/log

# Ensure storage permissions
chmod -R 777 /var/www/html/storage
chmod -R 777 /var/www/html/bootstrap/cache

# Check if Nginx configuration is valid
nginx -t || exit 1

# Start PHP-FPM
php-fpm -D || {
    echo "Failed to start PHP-FPM"
    exit 1
}

# Start Nginx in the foreground (this will keep the container running)
echo "Starting Nginx in foreground..."
exec nginx -g "daemon off;"
