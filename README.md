# double_back_to_close_app

[![pub package](https://img.shields.io/pub/v/double_back_to_close_app.svg)](https://pub.dartlang.org/packages/double_back_to_close_app)
[![ci workflow](https://github.com/hugocbpassos/double_back_to_close_app/workflows/CI/badge.svg)](https://github.com/hugocbpassos/double_back_to_close_app/actions?workflow=CI)
[![style: effective dart][https://img.shields.io/badge/style-effective_dart-40c4ff.svg]](https://github.com/tenhobi/effective_dart)

A Flutter package that allows Android users to press the back-button twice to close the app.

## Usage

Inside a `Scaffold` that wraps all your Widgets, place the `DoubleBackToCloseApp` passing a `SnackBar`:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DoubleBackToCloseApp(
          child: Home(),
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
        ),
      ),
    );
  }
}
``` 

## Motivation 

I've implemented such solution when I answered [this question](https://stackoverflow.com/a/56344092/6696558) in Stack Overflow,
 and since this feature seems to be implemented very often, I decided to extract it in a lightweight library. 
