# Weather Backend Application

This Laravel application provides a backend API for fetching weather forecasts from OpenWeatherMap.

## Requirements

- PHP 8.1 or higher
- Composer
- OpenWeatherMap API key

## Installation

1. Clone the repository
2. Install dependencies:
   ```
   composer install
   ```
3. Copy `.env.example` to `.env`:
   ```
   cp .env.example .env
   ```
4. Generate application key:
   ```
   php artisan key:generate
   ```
5. Set your OpenWeatherMap API key in the `.env` file:
   ```
   OPENWEATHERMAP_API_KEY=your_api_key_here
   ```

## Running the Application

Start the Laravel development server:
```
php artisan serve
```

The application will be available at http://localhost:8000.

## API Endpoints

### 1. Get Weather Forecast by City

```
GET /api/weather/forecast/city
```

**Parameters:**
- `city` (required): The name of the city to get weather data for
- `units` (optional): The units of measurement (imperial or metric, default: metric)

**Example:**
```
GET http://localhost:8000/api/weather/forecast/city?city=London&units=metric
```

### 2. Get Weather Forecast by Coordinates

```
GET /api/weather/forecast/coordinates
```

**Parameters:**
- `latitude` (required): The latitude coordinate
- `longitude` (required): The longitude coordinate
- `units` (optional): The units of measurement (imperial or metric, default: metric)

**Example:**
```
GET http://localhost:8000/api/weather/forecast/coordinates?latitude=51.5072&longitude=-0.1276&units=metric
```

## Response Format

```json
{
  "success": true,
  "data": {
    // OpenWeatherMap API response
  }
}
```

In case of an error:

```json
{
  "success": false,
  "message": "Error message",
  "error": {
    // Error details
  }
}
```

## Deployment

### Local Development

Start the Laravel development server:
```
php artisan serve
```

The application will be available at http://localhost:8000.

### Vercel Deployment

This application is configured for deployment on Vercel. For detailed deployment instructions, see the [Vercel Deployment Guide](VERCEL_DEPLOYMENT.md).

Quick steps:
1. Push your code to a GitHub repository
2. Connect your repository to Vercel
3. Set the `OPENWEATHERMAP_API_KEY` environment variable
4. Deploy

## Learning Laravel

Laravel has the most extensive and thorough [documentation](https://laravel.com/docs) and video tutorial library of all modern web application frameworks, making it a breeze to get started with the framework.

You may also try the [Laravel Bootcamp](https://bootcamp.laravel.com), where you will be guided through building a modern Laravel application from scratch.

If you don't feel like reading, [Laracasts](https://laracasts.com) can help. Laracasts contains thousands of video tutorials on a range of topics including Laravel, modern PHP, unit testing, and JavaScript. Boost your skills by digging into our comprehensive video library.

## Laravel Sponsors

We would like to extend our thanks to the following sponsors for funding Laravel development. If you are interested in becoming a sponsor, please visit the [Laravel Partners program](https://partners.laravel.com).

### Premium Partners

- **[Vehikl](https://vehikl.com)**
- **[Tighten Co.](https://tighten.co)**
- **[Kirschbaum Development Group](https://kirschbaumdevelopment.com)**
- **[64 Robots](https://64robots.com)**
- **[Curotec](https://www.curotec.com/services/technologies/laravel)**
- **[DevSquad](https://devsquad.com/hire-laravel-developers)**
- **[Redberry](https://redberry.international/laravel-development)**
- **[Active Logic](https://activelogic.com)**

## Contributing

Thank you for considering contributing to the Laravel framework! The contribution guide can be found in the [Laravel documentation](https://laravel.com/docs/contributions).

## Code of Conduct

In order to ensure that the Laravel community is welcoming to all, please review and abide by the [Code of Conduct](https://laravel.com/docs/contributions#code-of-conduct).

## Security Vulnerabilities

If you discover a security vulnerability within Laravel, please send an e-mail to Taylor Otwell via [taylor@laravel.com](mailto:taylor@laravel.com). All security vulnerabilities will be promptly addressed.

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
