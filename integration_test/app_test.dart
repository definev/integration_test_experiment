import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_tutorial/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "User doesn't fill in TextField"
    "Expect throw an errors",
    (WidgetTester tester) async {
      // Testing starts at the root widget in the widget tree
      await tester.pumpWidget(MyApp());

      await tester.tap(find.byType(FloatingActionButton));

      await tester.pumpAndSettle();

      expect(find.byType(TypingPage), findsOneWidget);
      expect(find.byType(DisplayPage), findsNothing);
      // This is the text displayed by an error message on the TextFormField
      expect(find.text('Input at least one character'), findsOneWidget);
    },
  );

  testWidgets(
    "Input text in TextField widget"
    "Expect go to second screen show that text input before",
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      // Input the text
      final inputText = "Hello Tester!~";
      await tester.enterText(find.byKey(Key("your-text-field")), inputText);

      // Tap FAB
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // We are in DisplayPage and have inputText in middle of the screen
      expect(find.byType(TypingPage), findsNothing);
      expect(find.byType(DisplayPage), findsOneWidget);
      expect(find.text(inputText), findsOneWidget);

      // Tap back button
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Back to TypingText
      expect(find.byType(TypingPage), findsOneWidget);
      expect(find.byType(DisplayPage), findsNothing);
      expect(find.text(inputText), findsNothing);
    },
  );
}
