# Deploying Laravel Weather Application to Vercel

This guide will help you deploy the Laravel Weather Application to Vercel.

## Prerequisites

1. A [Vercel](https://vercel.com) account
2. [Vercel CLI](https://vercel.com/cli) installed (optional, but recommended)
3. An OpenWeatherMap API key

## Deployment Steps

### 1. Set up Environment Variables in Vercel

Before deploying, make sure to set up your environment variables in the Vercel dashboard:

- `OPENWEATHERMAP_API_KEY`: Your OpenWeatherMap API key

### 2. Deploy to Vercel

#### Option 1: Using Vercel CLI

1. Install Vercel CLI if you haven't already:
   ```bash
   npm install -g vercel
   ```

2. Login to Vercel:
   ```bash
   vercel login
   ```

3. Navigate to your project directory and deploy:
   ```bash
   cd /path/to/weatherbackend
   vercel
   ```

4. Follow the prompts to configure your project.

#### Option 2: Using GitHub Integration

1. Push your code to a GitHub repository.
2. Log in to your Vercel account and create a new project.
3. Import your GitHub repository.
4. Configure the project:
   - Framework Preset: Laravel
   - Root Directory: ./
   - Build Command: composer install
5. Add the environment variables mentioned above.
6. Deploy!

### 3. Verify Deployment

After deployment, visit your Vercel app URL to verify that it's working. You can test the API endpoints:

- `https://your-vercel-app.vercel.app/api/weather/forecast/city?city=London&units=metric`
- `https://your-vercel-app.vercel.app/api/weather/forecast/coordinates?latitude=51.5072&longitude=-0.1276&units=imperial`

## Troubleshooting

- **404 Errors**: Make sure your routes are correctly defined in your Laravel application.
- **Server Errors**: Check the Vercel deployment logs for any issues.
- **API Key Issues**: Verify that your OpenWeatherMap API key is correctly set in the Vercel environment variables.

## Important Notes

1. Vercel has a serverless architecture, which means:
   - Long-running processes are not supported
   - File system changes are not persistent between requests
   
2. This deployment is optimized for an API-only Laravel application. If you need to serve frontend assets, additional configuration may be required.

3. The configuration in `vercel.json` routes all requests to the Laravel application, making it suitable for API-only applications.
