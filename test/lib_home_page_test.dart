// Import necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/home_page.dart';

void main() {
  group('JournalHome', () {
    testWidgets('should have a title', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: JournalHome()));
      expect(find.text('Journal Home'), findsOneWidget);
    });

    testWidgets('should have tabs', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: JournalHome()));
      expect(find.byType(TabBar), findsOneWidget);
      expect(find.byType(TabBarView), findsOneWidget);
    });
  });
}
