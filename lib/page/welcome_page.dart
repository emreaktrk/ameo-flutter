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
                  Page.create(
                      Title("Available", "Anywhere"),
                      "We know you have a lot to do. So, we make it easy to access your money any time, anywhere",
                      1),
                  Page.create(
                      Title(
                        "Oh You",
                        "Can",
                      ),
                      "Do what was previously impossible. No more waiting. Just tap and load your earnings.",
                      2),
                  Page.create(
                      Title("Its Yours", "Use It"),
                      "Pay bills. Fill your tank. Go shopping.\nReally... It's all up to you",
                      3),
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
  Title title;
  String description = "";
  int position;

  Page.create(this.title, this.description, this.position);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        Expanded(
          child: Image.network(
            "https://raw.githubusercontent.com/emreaktrk/ameo-flutter/master/assets/welcome_$position.png",
            fit: BoxFit.scaleDown,
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "${title.first}.\n",
                style: TextStyle(
                  color: ProjectColors.egyptian_blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              TextSpan(
                text: "${title.second}.",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: ProjectColors.egyptian_blue,
            width: MediaQuery.of(context).size.width / 6,
            height: 4.0,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 64.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class Title {
  Title(this.first, this.second);

  String first = "";
  String second = "";
}
