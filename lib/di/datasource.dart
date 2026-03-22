import 'package:google_places_sdk_plus/google_places_sdk_plus.dart';
import 'package:gusla/di/key_provider.dart';

abstract class Datasource<T> {
  T getDatasource();
}

class GooglePlacesSdkSource implements Datasource<FlutterGooglePlacesSdk> {
  final KeyProvider _keyProvider;

  GooglePlacesSdkSource({required KeyProvider keyProvider})
    : _keyProvider = keyProvider;

  @override
  FlutterGooglePlacesSdk getDatasource() {
    return FlutterGooglePlacesSdk(_keyProvider.getPlacesSdkKey());
  }
}
