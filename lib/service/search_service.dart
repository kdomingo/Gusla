import '../repository/search_repository.dart';

abstract class SearchService {
  Future<dynamic> search(String? query);
}

class SearchServiceImpl implements SearchService {
  final SearchRepository _repository;

  SearchServiceImpl({required SearchRepository repository})
    : _repository = repository;

  @override
  Future<dynamic> search(String? query) async {
    await _repository.search(query);
  }
}
