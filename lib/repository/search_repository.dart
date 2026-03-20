import 'package:google_places_sdk_plus/google_places_sdk_plus.dart';

abstract class SearchRepository {
  Future<dynamic> search(String? query);
}

class SearchRepositoryImpl implements SearchRepository {
  final FlutterGooglePlacesSdk _datasource;

  SearchRepositoryImpl({required FlutterGooglePlacesSdk datasource})
    : _datasource = datasource;

  @override
  Future<dynamic> search(String? query) async {
    if (null == query) return Future.value(null);
    return _datasource.findAutocompletePredictions(query);
  }
}
