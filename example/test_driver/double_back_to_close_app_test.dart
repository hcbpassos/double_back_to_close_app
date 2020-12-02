import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  final backButtonFinder = find.byType('OutlineButton');
  final snackBarFinder = find.byType('SnackBar');

  late final FlutterDriver driver;

  setUpAll(() async => driver = await FlutterDriver.connect());

  tearDownAll(() => driver.close());

  Future<bool> checkIfAppIsOpened() async {
    // Wait 1 second to make sure the app had enough time to close.
    await Future<void>.delayed(Duration(seconds: 1));
    return (await driver.getRenderTree()) != null;
  }

  test(
    'Given that `DoubleBackToCloseApp` was wrapped in a `Scaffold`. '
    'And that the back-button was tapped. '
    ''
    'When the `SnackBar` collapses. '
    'And the back-button is tapped again. '
    ''
    'Then another `SnackBar` is shown. '
    'And the app stills opened.',
    () async {
      // Given that `DoubleBackToCloseApp` was wrapped in a `Scaffold`.
      // And that the back-button was tapped.
      await driver.tap(backButtonFinder);
      await driver.waitFor(snackBarFinder);

      // When the `SnackBar` collapses.
      await driver.waitForAbsent(
        snackBarFinder,
        timeout: Duration(seconds: 5),
      );

      // And the back-button is tapped again.
      await driver.tap(backButtonFinder);

      // Then another `SnackBar` is shown.
      await driver.waitFor(snackBarFinder);

      // And the app stills opened.
      expect(await checkIfAppIsOpened(), isTrue);
    },
  );
}
