#!/bin/bash

# Vercel deployment script for Laravel Weather Application

echo "🚀 Preparing for Vercel deployment..."

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "❌ Vercel CLI is not installed. Please install it using 'npm install -g vercel'"
    exit 1
fi

# Check if user is logged in to Vercel
echo "🔑 Checking Vercel authentication status..."
VERCEL_TOKEN=$(vercel whoami 2>&1)
if [[ $VERCEL_TOKEN == *"Error"* ]]; then
    echo "⚠️ Not logged in to Vercel. Please login first."
    vercel login
fi

# Build the project
echo "🔨 Building project..."
composer install --optimize-autoloader --no-dev

# Environment configuration
echo "⚙️ Checking environment configuration..."
if [ ! -f .env.production ]; then
    echo "⚠️ .env.production file not found. Creating one based on .env..."
    cp .env .env.production
    echo "⚠️ Please edit .env.production to set production values before continuing."
    read -p "Press Enter to continue after editing .env.production..."
fi

# Deploy to Vercel
echo "🚀 Deploying to Vercel..."
vercel --prod

echo "✅ Deployment complete!"
echo "🔗 Your API endpoints should be available at:"
echo "   - /api/weather/forecast/city"
echo "   - /api/weather/forecast/coordinates"
echo ""
echo "🌐 Make sure to set the OPENWEATHERMAP_API_KEY environment variable in the Vercel dashboard."
