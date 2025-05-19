<?php

// Simple health check file for Fly.io deployment
// This file helps Fly.io verify that your application is responding to requests

header('Content-Type: application/json');
echo json_encode([
    'status' => 'healthy',
    'service' => 'Weather Backend API',
    'timestamp' => date('c'),
    'checks' => [
        'php' => version_compare(PHP_VERSION, '8.0.0', '>=') ? 'OK' : 'PHP version outdated',
        'laravel' => true,
        'environment' => app()->environment(),
    ]
]);
