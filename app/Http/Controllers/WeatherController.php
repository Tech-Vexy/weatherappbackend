<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class WeatherController extends Controller
{
    protected $apiKey;
    protected $baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';

    public function __construct()
    {
        $this->apiKey = env('OPENWEATHERMAP_API_KEY');
    }

    /**
     * Get weather forecast by city name
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function getForecastByCity(Request $request)
    {
        $request->validate([
            'city' => 'required|string',
            'units' => 'nullable|string|in:imperial,metric',
        ]);

        $city = $request->input('city');
        $units = $request->input('units', 'metric'); // Default to metric if not provided

        try {
            $response = Http::get($this->baseUrl, [
                'q' => $city,
                'units' => $units,
                'appid' => $this->apiKey,
            ]);

            if ($response->successful()) {
                return response()->json([
                    'success' => true,
                    'data' => $response->json(),
                ]);
            }

            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch weather data',
                'error' => $response->json(),
            ], $response->status());
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while fetching weather data',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Get weather forecast by coordinates
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function getForecastByCoordinates(Request $request)
    {
        $request->validate([
            'latitude' => 'required|numeric',
            'longitude' => 'required|numeric',
            'units' => 'nullable|string|in:imperial,metric',
        ]);

        $latitude = $request->input('latitude');
        $longitude = $request->input('longitude');
        $units = $request->input('units', 'metric'); // Default to metric if not provided

        try {
            $response = Http::get($this->baseUrl, [
                'lat' => $latitude,
                'lon' => $longitude,
                'units' => $units,
                'appid' => $this->apiKey,
            ]);

            if ($response->successful()) {
                return response()->json([
                    'success' => true,
                    'data' => $response->json(),
                ]);
            }

            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch weather data',
                'error' => $response->json(),
            ], $response->status());
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while fetching weather data',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
