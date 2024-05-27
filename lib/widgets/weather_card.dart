import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/weather_data.dart';
import '../providers/settings_provider.dart';

class WeatherCard extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherCard({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    // Map weather conditions to their corresponding colors
    Map<String, Color> weatherColors = {
      'Clear': Colors.yellow[700]!,
      'Haze': Colors.amber,
      'Rain': Color.fromARGB(255, 25, 210, 53),
      'Clouds': Color.fromARGB(178, 255, 124, 246)!,
      'Sunny': Colors.orange[600]!,
      'Snow': Colors.blueGrey[300]!,
      'Thunderstorm': Colors.purple[700]!,
      'Ash': Colors.grey[500]!,
      'Drizzle': Colors.lightBlue[300]!,
      'Tornado': Colors.deepPurple[800]!,
      'Default': Colors.amber[400]!, // Fallback color
    };

    // Determine the color for the current weather condition
    Color cardColor = weatherColors[weatherData.main] ?? weatherColors['Default']!;

    return Card(
      color: cardColor.withOpacity(0.9), 
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weatherData.cityName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Consumer<SettingsProvider>(
              builder: (context, settingsProvider, child) {
                final temperature = settingsProvider.isCelsius
                    ? weatherData.temperature
                    : (weatherData.temperature * 9 / 5) + 32;
                final unit = settingsProvider.isCelsius ? '°C' : '°F';
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Temperature: ${temperature.toStringAsFixed(1)}$unit',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Image.network(
                      'http://openweathermap.org/img/wn/${weatherData.icon}.png',
                      width: 70,
                      height: 60,
                    ),
                  ],
                );
              },
            ),
            Text(
              'Weather: ${weatherData.description}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
