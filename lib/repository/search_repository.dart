import 'package:google_places_sdk_plus/google_places_sdk_plus.dart';
import 'package:gusla/data/models/query.dart';
import 'package:gusla/di/datasource.dart';

abstract class SearchRepository {
  Future<dynamic> search(QueryOptions query);
}

class SearchRepositoryImpl implements SearchRepository {
  final FlutterGooglePlacesSdk _datasource;

  SearchRepositoryImpl({required Datasource datasource})
    : _datasource = datasource.getDatasource() as FlutterGooglePlacesSdk;

  @override
  Future<dynamic> search(QueryOptions query) async {
    final place = query.place;
    if (null == place) return Future.value(null);
    return _datasource.findAutocompletePredictions(
      place,
      origin: query.origin,
      countries: query.countries,
      locationBias: query.locationBias,
      locationRestriction: query.locationRestriction,
      placeTypesFilter: query.placeTypesFilter,
      newSessionToken: query.newSessionToken,
    );
  }
}
