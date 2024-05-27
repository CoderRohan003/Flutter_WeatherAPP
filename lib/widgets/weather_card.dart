import 'package:flutter/material.dart';
import '../models/weather_data.dart';

class WeatherCard extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherCard({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('City: ${weatherData.cityName}'),
            Text('Temperature: ${weatherData.temperature.toStringAsFixed(1)}°C'),
            Text('Description: ${weatherData.description}'),
          ],
        ),
      ),
    );
  }
}
