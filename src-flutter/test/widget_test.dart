// This is a basic Flutter widget test for Claudia Flutter app.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:claudia_flutter/main.dart';

void main() {
  testWidgets('Claudia Flutter app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: ClaudiaFlutterApp()));
    
    // Pump and settle to let animations complete
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Verify that our app title is displayed (appears twice - in title bar and main content).
    expect(find.text('Claudia Flutter'), findsNWidgets(2));
    expect(find.text('Phase 2: Core UI System Migration Complete!\nDesign System • Animations • Icons'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // Tap the 'Get Started' button
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Verify that the snackbar appears
    expect(find.text('Phase 2 Complete: Core UI System Migration!'), findsOneWidget);
  });
}
