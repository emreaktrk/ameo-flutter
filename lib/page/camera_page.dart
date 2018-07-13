import 'dart:async';
import 'dart:io';

import 'package:ameo/page/upload_page.dart';
import 'package:ameo/project_colors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:screentheme/screentheme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as Im;

class CameraPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CameraState();
  }
}

class CameraState extends State<CameraPage> {
  CameraController controller;

  @override
  void initState() {
    super.initState();

    ScreenTheme.updateNavigationBarColor(Colors.black);
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
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Scaffold(backgroundColor: Colors.black);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
          Expanded(
            child: new CameraButton(controller: controller),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class CameraButton extends StatelessWidget {
  const CameraButton({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FloatingActionButton(
        backgroundColor: ProjectColors.royal_blue,
        onPressed: () => takePicture(context, controller),
        child: Icon(Icons.camera, color: ProjectColors.white),
      ),
    );
  }
}

void takePicture(BuildContext context, CameraController controller) {
  getApplicationDocumentsDirectory().then((directory) {
    var file = File('${directory.path}/temp.jpg');
    if (file.existsSync()) {
      file.deleteSync();
    }

    controller.takePicture(file.path).then((_) {
      rootBundle.load(file.path).then((_) {
        compress(file).then((compressed) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => UploadPage.withFile(compressed),
              ),
              (Route<dynamic> route) => false);
        });
      });
    });
  });
}

Future<File> compress(File file) => getTemporaryDirectory().then((directory) {
      Im.Image original = Im.decodeImage(file.readAsBytesSync());
      Im.Image smaller = Im.copyResize(original, 1080);

      File compressed = new File(
          '${directory.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg');
      compressed.writeAsBytesSync(Im.encodeJpg(smaller, quality: 100));

      return Future<File>.value(compressed);
    }).catchError((error) {
      return Future<File>.error(null);
    });
