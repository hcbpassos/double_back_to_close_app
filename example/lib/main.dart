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
            content: Text('Tap back again to leave'),
          ),
          child: Center(
            child: OutlineButton(
              child: const Text('Tap to simulate back'),
              // ignore: invalid_use_of_protected_member
              onPressed: WidgetsBinding.instance.handlePopRoute,
            ),
          ),
        ),
      ),
    );
  }
}
