#!/bin/bash

# Simple startup script for the Laravel application

# Set up the PHP-FPM configuration
cat > /usr/local/etc/php-fpm.d/www.conf << 'EOF'
[www]
user = www-data
group = www-data
listen = /run/php/php-fpm.sock
listen.owner = www-data
listen.group = www-data
pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
EOF

# Start PHP-FPM
php-fpm -D

# Wait for PHP-FPM to create the socket
while [ ! -S /run/php/php-fpm.sock ]; do
  echo "Waiting for PHP-FPM socket..."
  sleep 1
done

# Ensure proper permissions
chmod 660 /run/php/php-fpm.sock
chown www-data:www-data /run/php/php-fpm.sock

# Ensure storage directory is writable
chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Start Nginx (this will keep the container running)
echo "Starting Nginx..."
exec nginx -g "daemon off;"
