import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_api_project/providers/settings_provider.dart';
import 'package:weather_api_project/screens/home_screen.dart';
import 'package:weather_api_project/screens/loading_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: WeatherApiProjectApp(),
    ),
  );
}

class WeatherApiProjectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingScreen(),
    );
  }
}
