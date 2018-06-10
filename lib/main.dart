import 'package:ameo/page/assistant_page.dart';
import 'package:ameo/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:screentheme/screentheme.dart';

void main() {
  ScreenTheme.updateNavigationBarColor(ProjectColors.royal_blue);

  runApp(new AmeoApp());
}

class AmeoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: ProjectColors.egyptian_blue,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: ProjectColors.egyptian_blue,
          scaffoldBackgroundColor: ProjectColors.egyptian_blue,
          accentColor: ProjectColors.aquamarine_blue),
      home: AssistantPage(),
    );
  }
}
