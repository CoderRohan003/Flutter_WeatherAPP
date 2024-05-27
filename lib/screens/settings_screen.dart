import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_api_project/providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Temperature Unit:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Consumer<SettingsProvider>(
              builder: (context, settingsProvider, child) {
                return Row(
                  children: [
                    Radio(
                      value: TemperatureUnit.celsius,
                      groupValue: settingsProvider.temperatureUnit,
                      onChanged: (value) {
                        settingsProvider.setTemperatureUnit(value!);
                      },
                    ),
                    const Text('Celsius'),
                    const SizedBox(width: 20),
                    Radio(
                      value: TemperatureUnit.fahrenheit,
                      groupValue: settingsProvider.temperatureUnit,
                      onChanged: (value) {
                        settingsProvider.setTemperatureUnit(value!);
                      },
                    ),
                    const Text('Fahrenheit'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
