import 'dart:async';
import 'dart:io';

import 'package:ameo/page/assistant_page.dart';
import 'package:ameo/page/error_page.dart';
import 'package:ameo/project_colors.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:screentheme/screentheme.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadPage extends StatelessWidget {
  final File file;
  final String link;

  UploadPage.withFile(this.file) {
    ScreenTheme.updateNavigationBarColor(ProjectColors.royal_blue);
    ScreenTheme.lightStatusBar();
    ScreenTheme.lightNavigationBar();

    FirebaseApp.configure(
      name: 'ameo-car',
      options: new FirebaseOptions(
        googleAppID: "1:132982621918:android:fd61a76344997a7e",
        gcmSenderID: "132982621918",
        apiKey: "AIzaSyBd220LCD6-eDXJKKd38USsVCZ-iYXkrNk",
        projectID: "ameo-car",
      ),
    );
  }

  UploadPage.withLink(this.link) {
    ScreenTheme.updateNavigationBarColor(ProjectColors.royal_blue);
    ScreenTheme.lightStatusBar();
    ScreenTheme.lightNavigationBar();
  }

  @override
  Widget build(BuildContext context) {
    if (file != null) {
      upload(file).then((url) {
        identify(url).then((faceId) {
          verify(faceId).then((isIdentical) {
            if (isIdentical) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AssistantPage()),
                  (Route<dynamic> route) => false);
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => ErrorPage("Unknown Driver")),
                  (Route<dynamic> route) => false);
            }
          });
        });
      });
    }

    if (link != null) {
      identify(link).then((faceId) {
        verify(faceId).then((isIdentical) {
          if (isIdentical) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => AssistantPage()),
                (Route<dynamic> route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => ErrorPage("Unknown Driver")),
                (Route<dynamic> route) => false);
          }
        });
      });
    }

    return Scaffold(
      backgroundColor: ProjectColors.egyptian_blue,
      body: SafeArea(
        child: Stack(
          children: [
            Gradient(),
            Uploading(),
            LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class Uploading extends StatelessWidget {
  const Uploading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "Uploading...",
      textScaleFactor: 2.0,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ));
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

Future<String> upload(File file) => FirebaseStorage.instance
        .ref()
        .child("${DateTime.now().millisecondsSinceEpoch}.jpeg")
        .putFile(file)
        .future
        .then((snapshot) {
      return Future<String>.value(snapshot.downloadUrl.toString());
    }).catchError((error) {
      return Future<String>.error(null);
    });

Future<String> identify(String url) => Dio()
        .post(
            "https://westeurope.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false",
            data: {"url": url},
            options: Options(
              headers: {
                "Ocp-Apim-Subscription-Key": "83bb236c22994d039b6a2a37441c2c98",
                "Content-Type": "application/octet-stream"
              },
            ))
        .then((response) {
      return Future<String>.value(response.data[0]["faceId"]);
    }).catchError((error) {
      return Future<String>.error(error);
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
