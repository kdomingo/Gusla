import 'package:bloc_test/bloc_test.dart';
import 'package:gusla/search/search_bloc.dart';
import 'package:gusla/service/search_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_bloc_tests.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [MockSpec<SearchService>(as: #MockSearchService)],
)
void main() {
  late SearchBloc searchBloc;

  final testQuery = "TEST QUERY";
  final testResult = "TEST QUERY";
  final mockService = MockSearchService();

  blocTest(
    'Emits processing result state',
    setUp: () => searchBloc = SearchBloc(mockService),
    build: () => searchBloc,
    act: (bloc) => bloc.add(SearchEvent.withQuery(query: "")),
    expect: () => [
      const SearchResults.processing(),
      const SearchResults.empty(),
    ],
    tearDown: () => searchBloc.close(),
  );

  blocTest(
    'Emits empty result state when query is empty',
    setUp: () => searchBloc = SearchBloc(mockService),
    build: () => searchBloc,
    act: (bloc) => bloc.add(SearchEvent.withQuery(query: "")),
    expect: () => [
      const SearchResults.processing(),
      const SearchResults.empty(),
    ],
    tearDown: () => searchBloc.close(),
  );

  blocTest(
    'Emits result state',
    setUp: () {
      searchBloc = SearchBloc(mockService);
      when(
        mockService.search(testQuery),
      ).thenAnswer((_) => Future.value(testResult));
    },
    build: () => searchBloc,
    act: (bloc) => bloc.add(SearchEvent.withQuery(query: testQuery)),
    wait: const Duration(milliseconds: 300),
    expect: () => [
      const SearchResults.processing(),
      const SearchResults.withData(data: ["1"]),
    ],
    verify: (bloc) => verify(mockService.search(testQuery)).called(1),
    tearDown: () => searchBloc.close(),
  );
}
