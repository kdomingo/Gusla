import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gusla/outlined_input_field.dart';
import 'package:gusla/search/search_bloc.dart';
import 'package:gusla/search/search_screen.dart';
import 'package:gusla/service/search_service.dart';
import 'package:gusla/util/strings.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_screen_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<SearchService>(as: #MockSearchService),
    MockSpec<SearchBloc>(as: #MockSearchBloc),
  ],
)
void main() {
  final mockSearchBloc = MockSearchBloc();

  final testWidget = MaterialApp(home: SearchScreen());

  setUp(() {
    when(mockSearchBloc.state).thenReturn(SearchResults.empty());
  });

  testWidgets('Search field should be present', (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);
    expect(find.byType(OutlinedInputField), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('Map action should be present', (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);
    expect(find.byType(OutlinedInputField), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });
}
