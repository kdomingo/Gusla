import 'package:google_places_sdk_plus/google_places_sdk_plus.dart';

import '../data/models/result.dart';
import '../repository/search_repository.dart';

abstract class SearchService {
  Future<Result> search(String? query);
}

class SearchServiceImpl implements SearchService {
  final SearchRepository _repository;

  SearchServiceImpl({required SearchRepository repository})
    : _repository = repository;

  @override
  Future<Result> search(String? query) async {
    final result = await _repository.search(query);
    if (null == result) {
      return Result.error(result.message ?? "");
    }
    return Result.withData(
      (result as FindAutocompletePredictionsResponse).predictions,
    );
  }
}
