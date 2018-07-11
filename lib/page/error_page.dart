import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String error;

  ErrorPage(this.error);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          error,
          textScaleFactor: 2.0,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
