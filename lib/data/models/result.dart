import 'package:google_places_sdk_plus/google_places_sdk_plus.dart';

class Result {
  final dynamic data;
  final bool success;
  final String? message;

  Result._({this.data, this.message, this.success = false});
  Result.withData(dynamic data) : this._(data: data, success: true);
  Result.error(String message) : this._(message: message);
}

class LocationResult extends Result {
  final bool requiresPermission;
  LocationResult._({
    this.requiresPermission = false,
    super.data,
    super.message,
    super.success,
  }) : super._();
  LocationResult.requiresResolution() : this._(requiresPermission: true);
  LocationResult.error() : this._();
  LocationResult.withData(LatLng data) : this._(data: data, success: true);
}
