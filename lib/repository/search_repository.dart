abstract class SearchRepository {
  Future<dynamic> search(String? query);
}

class SearchRepositoryImpl implements SearchRepository {
  @override
  Future<dynamic> search(String? query) {
    throw UnimplementedError();
  }
}
