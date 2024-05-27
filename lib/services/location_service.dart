import 'package:geolocator/geolocator.dart';
import '../models/location_data.dart';

class LocationService {
  Future<LocationData> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      throw Exception('Failed to get current location');
    }
  }
}
