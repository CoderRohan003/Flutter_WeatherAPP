import 'package:flutter/foundation.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isCelsius = true;

  bool get isCelsius => _isCelsius;

  void toggleTemperatureUnit() {
    _isCelsius = !_isCelsius;
    notifyListeners();
  }
}
