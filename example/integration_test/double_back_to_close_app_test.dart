import 'package:double_back_to_close_app_example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const snackBarTransitionDuration = Duration(milliseconds: 250);
  const snackBarDisplayDuration = Duration(milliseconds: 4000);

  final backButtonFinder = find.byType(OutlineButton);
  final snackBarFinder = find.byType(SnackBar);

  testWidgets(
    'Given that `DoubleBackToCloseApp` was wrapped in a `Scaffold`. '
    'And that the back-button was tapped. '
    ''
    'When the `SnackBar` collapses. '
    'And the back-button is tapped again. '
    ''
    'Then another `SnackBar` is shown. '
    'And the app still opened.',
    (tester) async {
      // Given that `DoubleBackToCloseApp` was wrapped in a `Scaffold`.
      await tester.pumpWidget(Example());

      // And that the back-button was tapped.
      expect(backButtonFinder, findsOneWidget);
      await tester.tap(backButtonFinder);
      await tester.pump(snackBarTransitionDuration);
      expect(snackBarFinder, findsOneWidget);

      // When the `SnackBar` collapses.
      await tester.pump(snackBarDisplayDuration);
      await tester.pump(snackBarTransitionDuration);
      expect(snackBarFinder, findsNothing);

      // And the back-button is tapped again.
      await tester.tap(backButtonFinder);

      // Then another `SnackBar` is shown.
      await tester.pump(snackBarTransitionDuration);
      expect(snackBarFinder, findsOneWidget);

      // And the app still opened.
      await tester.pumpAndSettle();
    },
  );
}
