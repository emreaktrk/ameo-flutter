library ameo.page.assistant_page.dart;

import 'package:ameo/model/emotion_executor.dart';
import 'package:ameo/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:screentheme/screentheme.dart';

EmotionExecutor executor = EmotionExecutor();

class AssistantPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AssistantState();
  }
}

class AssistantState extends State<AssistantPage> {
  @override
  void initState() {
    super.initState();

    ScreenTheme.updateNavigationBarColor(ProjectColors.royal_blue);
    ScreenTheme.lightStatusBar();
    ScreenTheme.lightNavigationBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.egyptian_blue,
      body: SafeArea(
        child: Stack(
          children: [
            Gradient(),
            Emotions(),
          ],
        ),
      ),
    );
  }
}

class Gradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ProjectColors.egyptian_blue, ProjectColors.royal_blue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

class Emotions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Center(
            child: MaterialButton(
              onPressed: () => executor.execute(AngryEmotionStrategy()),
              child: new Text("Angry"),
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: MaterialButton(
              onPressed: () => executor.execute(ScaredEmotionStrategy()),
              child: new Text("Scared"),
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: MaterialButton(
              onPressed: () => executor.execute(NeutralEmotionStrategy()),
              child: new Text("Neutral"),
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: MaterialButton(
              onPressed: () => executor.execute(HappyEmotionStrategy()),
              child: new Text("Happy"),
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
