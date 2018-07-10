library ameo.page.assistant_page.dart;

import 'dart:async';
import 'dart:io';

import 'package:ameo/model/emotion.dart';
import 'package:ameo/model/emotion_executor.dart';
import 'package:ameo/project_colors.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screentheme/screentheme.dart';

Emotion emotion = Emotion("Calm down..");
EmotionExecutor executor = EmotionExecutor();

class AssistantPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AssistantState();
  }
}

class AssistantState extends State<AssistantPage> {
  CameraController controller;

  @override
  void initState() {
    super.initState();

    ScreenTheme.updateNavigationBarColor(ProjectColors.royal_blue);
    ScreenTheme.darkStatusBar();
    ScreenTheme.lightNavigationBar();

    availableCameras().then((cameras) {
      controller = CameraController(cameras[0], ResolutionPreset.low);

      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });

    new Timer.periodic(const Duration(seconds: 10), (_) {
      emotion = new Emotion('feeling');

      setState(() {
        getApplicationDocumentsDirectory().then((directory) {
          var file = File('${directory.path}/temp.jpg');
          if (file.existsSync()) {
            file.deleteSync();
          }

          controller.takePicture(file.path).then((_) {
            rootBundle.load(file.path).then((_) {
              identify().then((faceId) {
                verify(faceId).then((isIdentical) {
                  print(isIdentical);
                });
              });
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Gradient(),
            Headline(),
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

class Headline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: new Center(
        child: Text(
          emotion.toString(),
          textScaleFactor: 4.0,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ProjectColors.aquamarine_blue,
          ),
        ),
      ),
    );
  }
}

class Emotions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              onPressed: () => executor.execute(AngryEmotionStrategy()),
              child: new Text("Angry"),
              color: Colors.white,
            ),
          ),
          Expanded(
            child: MaterialButton(
              onPressed: () {},
              child: new Text("Scared"),
              color: Colors.white,
            ),
          ),
          Expanded(
            child: MaterialButton(
              onPressed: () {},
              child: new Text("Neutral"),
              color: Colors.white,
            ),
          ),
          Expanded(
            child: MaterialButton(
              onPressed: () => executor.execute(HappyEmotionStrategy()),
              child: new Text("Happy"),
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

Future<String> identify() => Dio()
        .post(
            "https://westeurope.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false",
            data: {
              "url":
                  "https://static-cdn.jtvnw.net/jtv_user_pictures/emreaktrk-profile_image-a8422f3eab0c7a93-300x300.jpeg"
            },
            options: Options(
              headers: {
                "Ocp-Apim-Subscription-Key": "83bb236c22994d039b6a2a37441c2c98",
                "Content-Type": "application/octet-stream"
              },
            ))
        .then((response) {
      return Future<String>.value(response.data[0]["faceId"]);
    }).catchError((error) {
      return Future<String>.value(null);
    });

Future<bool> verify(String faceId) => Dio()
        .post("https://westeurope.api.cognitive.microsoft.com/face/v1.0/verify",
            data: {
              "faceId": faceId,
              "personId": "257d4482-93b0-4ed7-854e-f110310a15f3",
              "PersonGroupId": "1"
            },
            options: Options(
              headers: {
                "Ocp-Apim-Subscription-Key": "83bb236c22994d039b6a2a37441c2c98",
                "Content-Type": "application/json"
              },
            ))
        .then((response) {
      return Future<bool>.value(response.data["isIdentical"]);
    }).catchError((error) {
      return Future<bool>.value(false);
    });
