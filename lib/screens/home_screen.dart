// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_api_project/models/weather_data.dart';
import 'package:weather_api_project/services/weather_api_service.dart';
import 'package:weather_api_project/screens/settings_screen.dart';
import 'package:weather_api_project/providers/settings_provider.dart';
import 'package:weather_api_project/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherData? _weatherData;
  WeatherApiService _weatherApiService = WeatherApiService();
  String _currentLocation = "Kolkata";

  // Map weather descriptions to their corresponding asset paths
  Map<String, String> weatherImages = {
    'Haze': 'assets/hazy.jpg',
    'Rain': 'assets/rain.jpeg',
    'Clouds': 'assets/cloudy.jpeg',
    'Sunny': 'assets/sunny.jpeg',
    'Snow': 'assets/snow.jpeg',
    'Thunderstorm': 'assets/thunderstorm.jpeg',
    'Ash': 'assets/ash.jpg',
    'Drizzle': 'assets/drizzle.jpg',
    'Tornado': 'assets/tornado.jpg',
    'default': 'assets/default.jpeg', // Fallback image
  };

  @override
  void initState() {
    super.initState();
    _fetchWeatherData(_currentLocation);
  }

  Future<void> _fetchWeatherData(String location) async {
    try {
      WeatherData weatherData = await _weatherApiService.getWeatherData(location);
      setState(() {
        _weatherData = weatherData;
      });
      print("Weather Data Fetched: ${weatherData.main}"); // Debug output
    } catch (e) {
      print("Error fetching weather data: $e");
    }
  }

  String _preprocessWeatherDescription(String description) {
    // Preprocess certain weather descriptions to match the mapped strings
    if (description.toLowerCase().contains('overcast clouds')) {
      return 'cloudy';
    }
    // Add more preprocessing rules if needed
    return description.toLowerCase();
  }

  void _changeLocation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newLocation = "";
        return AlertDialog(
          title: const Text("Enter Location"),
          content: TextField(
            onChanged: (value) {
              newLocation = value;
            },
            decoration: const InputDecoration(hintText: "Enter location"),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _currentLocation = newLocation;
                  _fetchWeatherData(_currentLocation);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 6,
        title: const Row(
          children: [
            Expanded(
              child: Text(
                'Weather App',
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.black,
            onPressed: _navigateToSettings,
          ),
          IconButton(
            icon: const Icon(Icons.location_on),
            color: Colors.black,
            onPressed: _changeLocation,
          ),
        ],
      ),
      body: _weatherData != null
          ? Stack(
              children: [
                // Background image
                Positioned.fill(
                  child: Image.asset(
                    weatherImages[_weatherData!.main] ?? weatherImages['default']!,
                    fit: BoxFit.cover,
                  ),
                ),
                // Weather card container
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3, 
                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: WeatherCard(weatherData: _weatherData!),
                      ),
                    
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
