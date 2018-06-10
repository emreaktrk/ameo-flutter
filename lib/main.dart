import 'package:ameo/page/assistant_page.dart';
import 'package:ameo/page/welcome_page.dart';
import 'package:ameo/project_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new AmeoApp());
}

class AmeoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: ProjectColors.egyptian_blue,
      home: WelcomePage(),
    );
  }
}
