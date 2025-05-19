# Deploying to Fly.io

This guide will help you deploy the Weather Backend application to Fly.io.

## Prerequisites

1. Install the Fly.io CLI tool:
   ```bash
   curl -L https://fly.io/install.sh | sh
   ```

2. Authenticate with Fly.io:
   ```bash
   fly auth login
   ```

3. Make sure you have your OpenWeatherMap API key ready

## Deployment Steps

1. Set your OpenWeatherMap API key as a secret:
   ```bash
   fly secrets set OPENWEATHERMAP_API_KEY=your_api_key_here
   ```

2. Deploy the application:
   ```bash
   fly deploy
   ```

3. Check if the application has been deployed successfully:
   ```bash
   fly status
   ```

4. Open the application in your browser:
   ```bash
   fly open
   ```

## Troubleshooting

If you encounter any issues during deployment, you can check the logs:

```bash
fly logs
```

To check the health of your application:

```bash
curl https://yourapp.fly.dev/fly-health.php
```

To SSH into your application for debugging:

```bash
fly ssh console
```

## API Endpoints

Once deployed, your API endpoints will be available at:

- `https://yourapp.fly.dev/api/weather/forecast/city?city=London&units=metric`
- `https://yourapp.fly.dev/api/weather/forecast/coordinates?latitude=51.5072&longitude=-0.1276&units=imperial`

Replace `yourapp.fly.dev` with your actual Fly.io app domain.
