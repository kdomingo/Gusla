import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:gusla/data/models/query.dart';
import 'package:gusla/data/models/result.dart';
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

  final testResult = Result.withData([]);
  final mockService = MockSearchService();

  final emptyQueryEvent = SearchEvent.withQuery(query: QueryOptions(place: ""));
  final normalQueryEvent = SearchEvent.withQuery(
    query: QueryOptions(place: "TEST_QUERY"),
  );

  blocTest(
    'Emits processing result state',
    setUp: () => searchBloc = SearchBloc(mockService),
    build: () => searchBloc,
    act: (bloc) => bloc.add(emptyQueryEvent),
    expect: () => [const SearchResult.processing(), const SearchResult.empty()],
    tearDown: () => searchBloc.close(),
  );

  blocTest(
    'Emits empty result state when query is empty',
    setUp: () => searchBloc = SearchBloc(mockService),
    build: () => searchBloc,
    act: (bloc) => bloc.add(emptyQueryEvent),
    expect: () => [const SearchResult.processing(), const SearchResult.empty()],
    tearDown: () => searchBloc.close(),
  );

  blocTest(
    'Emits result state',
    setUp: () {
      searchBloc = SearchBloc(mockService);
      when(mockService.search(any)).thenAnswer((_) => Future.value(testResult));
    },
    build: () => searchBloc,
    act: (bloc) => bloc.add(normalQueryEvent),
    wait: const Duration(milliseconds: 300),
    expect: () => [
      const SearchResult.processing(),
      SearchResult.withData(data: testResult.data),
    ],
    verify: (bloc) => verify(mockService.search(any)).called(1),
    tearDown: () => searchBloc.close(),
  );
}
