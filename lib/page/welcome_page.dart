import 'package:ameo/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:screentheme/screentheme.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WelcomeState();
  }
}

class WelcomeState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();

    ScreenTheme.updateNavigationBarColor(ProjectColors.white);
    ScreenTheme.darkStatusBar();
    ScreenTheme.darkNavigationBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: FlatButton(
                child: Text(
                  "SKIP",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Page.create("1", "1"),
                  Page.create("2", "2"),
                  Page.create("3", "3"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Page extends StatelessWidget {
  String title = "";
  String description = "";

  Page.create(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        textScaleFactor: 2.0,
      ),
    );
  }
}
