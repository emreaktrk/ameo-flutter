import 'package:ameo/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:screentheme/screentheme.dart';
import 'package:ameo/page/assistant_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WelcomeState();
  }
}

class WelcomeState extends State<WelcomePage> {
  final PageController controller = PageController();

  @override
  void initState() {
    super.initState();

    ScreenTheme.updateNavigationBarColor(ProjectColors.white);
    ScreenTheme.darkStatusBar();
    ScreenTheme.darkNavigationBar();
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward, color: ProjectColors.white),
        backgroundColor: ProjectColors.aquamarine_blue,
        onPressed: () => controller.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn),
      ),
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
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => AssistantPage()),
                    (Route<dynamic> route) => false),
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller,
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
    return new Column(
      children: [
        Expanded(
          child: Image.network(
            "https://raw.githubusercontent.com/emreaktrk/ameo-flutter/master/assets/welcome_$title.png",
            fit: BoxFit.scaleDown,
          ),
        ),
      ],
    );
  }
}
