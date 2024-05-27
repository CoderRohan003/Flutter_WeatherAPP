import 'package:flutter/material.dart';

enum TemperatureUnit { celsius, fahrenheit }

class SettingsProvider extends ChangeNotifier {
  TemperatureUnit _temperatureUnit = TemperatureUnit.celsius;

  TemperatureUnit get temperatureUnit => _temperatureUnit;

  void setTemperatureUnit(TemperatureUnit unit) {
    _temperatureUnit = unit;
    notifyListeners();
  }

  bool get isCelsius => _temperatureUnit == TemperatureUnit.celsius;
}
