#!/bin/bash

# Create a file to log startup progress
LOG_FILE="/var/log/fly-init.log"
echo "Starting initialization process at $(date)" > $LOG_FILE

# Run database migrations if DB is configured
if grep -q "DB_CONNECTION=mysql" /var/www/html/.env || grep -q "DB_CONNECTION=pgsql" /var/www/html/.env; then
    echo "Running database migrations..." >> $LOG_FILE
    cd /var/www/html && php artisan migrate --force >> $LOG_FILE 2>&1
fi

# Create a health check endpoint
echo "Creating health check endpoint..." >> $LOG_FILE
cat > /var/www/html/public/fly-health-check.php << 'EOF'
<?php
header("Content-Type: application/json");

$status = [
    "status" => "healthy",
    "timestamp" => date("c"),
    "environment" => php_sapi_name(),
    "server_ip" => $_SERVER['SERVER_ADDR'] ?? 'unknown',
    "client_ip" => $_SERVER['REMOTE_ADDR'] ?? 'unknown',
    "laravel" => true
];

echo json_encode($status, JSON_PRETTY_PRINT);
EOF

# Verify Nginx configuration
echo "Checking Nginx configuration..." >> $LOG_FILE
nginx -t >> $LOG_FILE 2>&1 || {
    echo "Nginx configuration test failed" >> $LOG_FILE
    exit 1
}

# Clear Laravel caches
echo "Clearing Laravel caches..." >> $LOG_FILE
cd /var/www/html && php artisan optimize:clear >> $LOG_FILE 2>&1

# Set proper permissions
echo "Setting proper permissions..." >> $LOG_FILE
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Final success message
echo "Initialization completed successfully at $(date)" >> $LOG_FILE

# This script will be executed before application startup
echo "Application initialized and ready to serve requests" >> $LOG_FILE
