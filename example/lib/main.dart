import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

void main() => runApp(Example());

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            key: ValueKey('snack_bar'),
            content: Text('Tap back again to leave'),
          ),
          child: Center(
            child: OutlineButton(
              key: ValueKey('back_button'),
              child: Text('Tap to simulate back'),
              onPressed: WidgetsBinding.instance.handlePopRoute,
            ),
          ),
        ),
      ),
    );
  }
}
