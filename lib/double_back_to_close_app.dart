library double_back_to_close_app;

import 'dart:io';

import 'package:flutter/material.dart';

/// Allows the user to close the app by double tapping the back-button.
///
/// You must specify a [SnackBar], so it can be shown when the user taps the
/// back-button. Notice that the value you set for [SnackBar.duration] is going
/// to be considered to decide whether the SnackBar is currently visible or not.
///
/// Since the back-button is an Android feature, this Widget is going to be
/// nothing but the own [child] if the current platform is anything but Android.
class DoubleBackToCloseApp extends StatefulWidget {
  final SnackBar snackBar;
  final Widget child;

  const DoubleBackToCloseApp({
    Key key,
    @required this.snackBar,
    @required this.child,
  })  : assert(snackBar != null),
        assert(child != null),
        super(key: key);

  @override
  DoubleBackToCloseAppState createState() => DoubleBackToCloseAppState();
}

@visibleForTesting
class DoubleBackToCloseAppState extends State<DoubleBackToCloseApp> {
  DateTime lastTimeBackButtonWasTapped;

  bool get isAndroid => Theme.of(context).platform == TargetPlatform.android;

  bool get isSnackBarVisible =>
      (lastTimeBackButtonWasTapped == null) ||
      (DateTime.now().difference(lastTimeBackButtonWasTapped) >
          widget.snackBar.duration);

  @override
  Widget build(BuildContext context) {
    ensureThatContextContainsScaffold(context);

    if (isAndroid) {
      return WillPopScope(
        onWillPop: () => onWillPop(context),
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }

  Future<bool> onWillPop(BuildContext context) async {
    if (isSnackBarVisible) {
      lastTimeBackButtonWasTapped = DateTime.now();
      Scaffold.of(context).showSnackBar(widget.snackBar);
      return false;
    } else {
      return true;
    }
  }

  void ensureThatContextContainsScaffold(BuildContext context) {
    if (Scaffold.of(context, nullOk: true) == null) {
      throw AssertionError(
        '`DoubleBackToCloseApp` should be wrapped in a `Scaffold`.',
      );
    }
  }
}
