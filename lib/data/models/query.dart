import 'package:google_places_sdk_plus/google_places_sdk_plus.dart';

class QueryOptions {
  final String? place;
  final List<String>? countries;
  final List<String> placeTypesFilter = const [];
  final bool? newSessionToken;
  final LatLng? origin;
  final LatLngBounds? locationBias;
  final LatLngBounds? locationRestriction;

  QueryOptions({
    required this.place,
    this.countries,
    this.newSessionToken,
    this.origin,
    this.locationBias,
    this.locationRestriction,
  });
}
