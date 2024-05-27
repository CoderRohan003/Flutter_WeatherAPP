import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_data.dart';

class WeatherApiService {
  static const String apiKey = '911c6d62bf5d1927cc9004fc93557587';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherData> getWeatherData(String location) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$location&appid=$apiKey&units=metric'));
    
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return WeatherData.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
