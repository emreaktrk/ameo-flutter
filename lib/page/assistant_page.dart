library ameo.page.assistant_page.dart;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ameo/model/emotion.dart';
import 'package:ameo/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:screentheme/screentheme.dart';

Emotion emotion = Emotion("Calm down..");
Future<Directory> directory = getApplicationDocumentsDirectory();

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

    new Timer(const Duration(milliseconds: 4000), () {
      setState(() {
        getApplicationDocumentsDirectory().then((directory) {
          controller.takePicture(directory.path + "/temp6.jpg").then((_) {
            rootBundle.load(directory.path + "/temp6.jpg").then((_) {
              File(directory.path + "/temp6.jpg").readAsBytes().then((bytes) {
                base64Encode(bytes);
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
      body: Stack(
        children: [
          Gradient(),
          Headline(),
          AspectRatio(
            child: CameraPreview(controller),
            aspectRatio: controller.value.aspectRatio,
          ),
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
