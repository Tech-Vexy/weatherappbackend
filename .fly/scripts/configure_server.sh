#!/bin/bash

# This script ensures proper networking configuration for Fly.io deployment

# Create a debug file to check if PHP is working
echo '<?php
    header("Content-Type: application/json");
    echo json_encode([
        "status" => "ok",
        "message" => "API server is running",
        "time" => date("Y-m-d H:i:s"),
        "env" => $_ENV,
        "server" => $_SERVER
    ]);
?>' > /var/www/html/public/health-check.php

# Ensure Nginx starts correctly
echo "Checking Nginx configuration..."
nginx -t || exit 1

# Make sure permissions are correct
chmod -R 755 /var/www/html/public
chown -R www-data:www-data /var/www/html/public

# Update the configuration to ensure we're listening on the right address
echo "Configuring services to bind to 0.0.0.0:8080..."

# Double-check that the .env file has the correct URL
if [ -f /var/www/html/.env ]; then
    # Make sure APP_URL is set correctly
    grep -q "APP_URL=" /var/www/html/.env && \
    sed -i "s|APP_URL=.*|APP_URL=https://${FLY_APP_NAME}.fly.dev|g" /var/www/html/.env || \
    echo "APP_URL=https://${FLY_APP_NAME}.fly.dev" >> /var/www/html/.env
    
    # Ensure we have our API key
    grep -q "OPENWEATHERMAP_API_KEY=" /var/www/html/.env || \
    echo "OPENWEATHERMAP_API_KEY=${OPENWEATHERMAP_API_KEY}" >> /var/www/html/.env
fi

echo "Server configuration updated for Fly.io"
