#!/bin/bash

# Create a simple test file that will show PHP is running
echo '<?php
    header("Content-Type: application/json");
    echo json_encode([
        "status" => "ok",
        "message" => "API server is running",
        "environment" => $_ENV,
        "server" => $_SERVER
    ]);
?>' > /var/www/html/public/status.php

# Make sure permissions are correct
chmod -R 755 /var/www/html/public
chown -R www-data:www-data /var/www/html/public

echo "Created status endpoint for checking server"
