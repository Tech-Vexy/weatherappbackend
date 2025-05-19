<?php
// Simple health check endpoint for Fly.io
header('Content-Type: application/json');

echo json_encode([
    'status' => 'ok',
    'service' => 'Weather Backend API',
    'timestamp' => date('c'),
    'environment' => $_ENV['APP_ENV'] ?? 'unknown',
]);
