import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() => driver?.close());

  Future<bool> isAppOpened() async {
    // Wait 1 second to make sure the app had enough time to close.
    await Future.delayed(Duration(seconds: 1));
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
      SerializableFinder backButtonFinder = find.byValueKey('back_button');
      SerializableFinder snackBarFinder = find.byValueKey('snack_bar');

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
      expect(await isAppOpened(), isTrue);
    },
  );
}
