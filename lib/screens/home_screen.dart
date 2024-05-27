import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_api_project/models/weather_data.dart';
import 'package:weather_api_project/services/weather_api_service.dart';
import 'package:weather_api_project/screens/settings_screen.dart';
import 'package:weather_api_project/providers/settings_provider.dart';

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
    'haze': 'assets/haze.jpeg',
    'rain': 'assets/rain.jpeg',
    'clouds': 'assets/cloudy.jpeg',
    'sunny': 'assets/sunny.jpeg',
    'snow': 'assets/snow.jpeg',
    'thunderstorm': 'assets/thunderstorm.jpeg',
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
      print("Weather Data Fetched: ${weatherData.description}"); 
    } catch (e) {
      print("Error fetching weather data: $e");
    }
  }

  void _changeLocation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newLocation = "";
        return AlertDialog(
          title: Text("Enter Location"),
          content: TextField(
            onChanged: (value) {
              newLocation = value;
            },
            decoration: InputDecoration(hintText: "Enter location"),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("OK"),
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
        title: Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _navigateToSettings,
          ),
          IconButton(
            icon: Icon(Icons.location_on),
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
                    weatherImages[_weatherData!.description.toLowerCase()] ?? weatherImages['default']!,
                    fit: BoxFit.cover,
                  ),
                ),
                // Weather details
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'City: ${_weatherData!.cityName}',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Consumer<SettingsProvider>(
                              builder: (context, settingsProvider, child) {
                                final temperature = settingsProvider.isCelsius
                                    ? _weatherData!.temperature
                                    : (_weatherData!.temperature * 9 / 5) + 32;
                                final unit = settingsProvider.isCelsius ? '°C' : '°F';
                                return Text(
                                  'Temperature: ${temperature.toStringAsFixed(1)}$unit',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                            Text(
                              'Description: ${_weatherData!.description}',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
