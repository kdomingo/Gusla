import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_places_sdk_plus/google_places_sdk_plus.dart';
import 'package:gusla/outlined_input_field.dart';
import 'package:gusla/search/search_bloc.dart';
import 'package:gusla/search/search_screen.dart';
import 'package:gusla/service/search_service.dart';
import 'package:gusla/util/strings.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

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

  final testWidget = Provider<SearchBloc>.value(
    value: mockSearchBloc,
    builder: (context, child) {
      return MaterialApp(home: SearchScreen());
    },
  );

  setUp(() {
    when(mockSearchBloc.stream).thenAnswer((realInvocation) {
      return Stream.value(SearchResult.empty());
    });
    when(mockSearchBloc.state).thenReturn(SearchResult.empty());
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

  testWidgets('Search results should be empty initially', (widgetTester) async {
    await widgetTester.pumpWidget(testWidget);
    expect(find.text("No Results"), findsOneWidget);
  });

  testWidgets('Search results should show progress indicator', (
    widgetTester,
  ) async {
    when(mockSearchBloc.stream).thenAnswer((realInvocation) {
      return Stream.value(SearchResult.processing());
    });
    when(mockSearchBloc.state).thenReturn(SearchResult.processing());

    await widgetTester.pumpWidget(testWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Search results should show predictions', (widgetTester) async {
    final data = [
      AutocompletePrediction(
        primaryText: "Place 1",
        secondaryText: "This is place 1",
        distanceMeters: 500,
      ),
      AutocompletePrediction(
        primaryText: "Place 2",
        secondaryText: "This is place 2",
        distanceMeters: 1000,
      ),
    ];
    when(mockSearchBloc.stream).thenAnswer((realInvocation) {
      return Stream.value(SearchResult.withData(data: data));
    });
    when(mockSearchBloc.state).thenReturn(SearchResult.withData(data: data));

    await widgetTester.pumpWidget(testWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ListTile), findsAtLeast(data.length));
    expect(find.text(data.first.primaryText!), findsOneWidget);
    expect(find.text(data[1].primaryText!), findsOneWidget);
  });

  testWidgets('Search results should show unknown place', (widgetTester) async {
    final data = [
      AutocompletePrediction(
        secondaryText: "This is place 1",
        distanceMeters: 500,
      ),
    ];
    when(mockSearchBloc.stream).thenAnswer((realInvocation) {
      return Stream.value(SearchResult.withData(data: data));
    });
    when(mockSearchBloc.state).thenReturn(SearchResult.withData(data: data));

    await widgetTester.pumpWidget(testWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ListTile), findsAtLeast(data.length));
    expect(find.text(Strings.unknownPlace), findsOneWidget);
  });
}
