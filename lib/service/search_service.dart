import 'package:google_places_sdk_plus/google_places_sdk_plus.dart';
import 'package:gusla/data/models/query.dart';

import '../data/models/result.dart';
import '../repository/search_repository.dart';

abstract class SearchService {
  Future<Result> search(QueryOptions query);
}

class SearchServiceImpl implements SearchService {
  final SearchRepository _repository;

  SearchServiceImpl({required SearchRepository repository})
    : _repository = repository;

  @override
  Future<Result> search(QueryOptions query) async {
    final result = await _repository.search(query).onError((error, stackTrace) {
      return null;
    });

    if (null == result) {
      return Result.error("Could not find places.");
    }

    return Result.withData(
      (result as FindAutocompletePredictionsResponse?)?.predictions,
    );
  }
}
