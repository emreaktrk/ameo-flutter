library ameo.page.assistant_page.dart;

import 'dart:async';
import 'dart:io';

import 'package:ameo/model/emotion.dart';
import 'package:ameo/project_colors.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screentheme/screentheme.dart';

Emotion emotion = Emotion("Calm down..");

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
    ScreenTheme.lightStatusBar();
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
              Dio()
                  .post(
                      'https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize?',
                      data: FormData.from({
                        "file": UploadFileInfo(file, "temp.jpg"),
                      }),
                      options: Options(headers: {'key1': '', 'key2': ''}))
                  .then((response) {});
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Gradient(),
          Headline(),
        ],
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
