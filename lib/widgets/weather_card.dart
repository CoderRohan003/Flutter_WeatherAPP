import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/weather_data.dart';
import 'package:weather_api_project/providers/settings_provider.dart';

class WeatherCard extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherCard({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(176, 255, 255, 255),
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
                    color: Color.fromARGB(255, 5, 5, 5),
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
                        color: Color.fromARGB(255, 5, 5, 5),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto', 
                      ),
                    ),
                    Image.network(
                  'http://openweathermap.org/img/wn/${weatherData.icon}.png',
                  width: 60,
                  height:60,
                ),
                  ],
                );
              },
            ),
            Text(
              'Weather: ${weatherData.description}',
              style: const TextStyle(
                color: Color.fromARGB(255, 5, 5, 5),
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
