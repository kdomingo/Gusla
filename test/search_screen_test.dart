import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gusla/outlined_input_field.dart';
import 'package:gusla/search/search_screen.dart';

void main() {
  const testWidget = MaterialApp(home: SearchScreen());

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
