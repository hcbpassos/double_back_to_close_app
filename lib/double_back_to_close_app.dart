import 'package:flutter/material.dart';

/// Allows the user to close the app by double tapping the back-button.
///
/// You must specify a [SnackBar], so it can be shown when the user taps the
/// back-button.
///
/// Since the back-button is an Android feature, this Widget is going to be
/// nothing but return the own [child] if the current platform is anything but Android.
class DoubleBackToCloseApp extends StatefulWidget {
  /// The [SnackBar] shown when the user taps the back-button.
  final SnackBar snackBar;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Creates a widget that allows the user to close the app by double tapping
  /// the back-button.
  const DoubleBackToCloseApp({
    Key? key,
    required this.snackBar,
    required this.child,
  }) : super(key: key);

  @override
  DoubleBackToCloseAppState createState() => DoubleBackToCloseAppState();
}

class DoubleBackToCloseAppState extends State<DoubleBackToCloseApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isAndroid = Theme.of(context).platform == TargetPlatform.android;
      if (isAndroid) _addLocalHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(() {
      _ensureScaffoldChild();
      return true;
    }());

    return widget.child;
  }

  /// Throws a [FlutterError] if this widget was not wrapped in a [Scaffold],
  /// because this is a requirement to show snack bars.
  void _ensureScaffoldChild() {
    if (Scaffold.maybeOf(context) == null) {
      throw FlutterError(
        '`DoubleBackToCloseApp` must be wrapped in a `Scaffold`.',
      );
    }
  }

  void _addLocalHistory() {
    ModalRoute.of(context)?.addLocalHistoryEntry(
      LocalHistoryEntry(
        impliesAppBarDismissal: false,
        onRemove: _showSnackBar,
      ),
    );
  }

  void _showSnackBar() {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.hideCurrentSnackBar();
    scaffoldMessenger
        .showSnackBar(widget.snackBar)
        .closed
        .whenComplete(_addLocalHistory);
  }
}
