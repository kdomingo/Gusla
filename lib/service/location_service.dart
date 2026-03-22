import 'package:geolocator/geolocator.dart';
import 'package:google_places_sdk_plus/google_places_sdk_plus.dart';
import 'package:gusla/data/models/result.dart';

abstract class LocationService {
  Future<LocationResult> getLocation();
}

class LocationServiceImpl implements LocationService {
  @override
  Future<LocationResult> getLocation() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      return LocationResult.requiresResolution();
    }

    var accessLevel = await Geolocator.checkPermission();
    if (accessLevel == LocationPermission.denied) {
      accessLevel = await Geolocator.requestPermission();
      if (accessLevel == LocationPermission.denied) {
        return LocationResult.requiresResolution();
      }
    }
    if (accessLevel == LocationPermission.deniedForever) {
      return LocationResult.requiresResolution();
    }

    final position = await Geolocator.getCurrentPosition();
    return LocationResult.withData(
      LatLng(lat: position.latitude, lng: position.longitude),
    );
  }
}
