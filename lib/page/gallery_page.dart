import 'package:ameo/page/upload_page.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Spacer(),
              ProfileButton(
                "https://static-cdn.jtvnw.net/jtv_user_pictures/emreaktrk-profile_image-a8422f3eab0c7a93-300x300.jpeg",
                "emre.jpg",
              ),
              Spacer(),
              ProfileButton(
                "https://i.imgur.com/l70hJ.jpg",
                "burak.jpg",
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String link;
  final String asset;

  ProfileButton(this.link, this.asset);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigate(context, link),
      child: Container(
        width: 240.0,
        height: 240.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(asset),
          ),
        ),
      ),
    );
  }
}

void navigate(BuildContext context, String link) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => UploadPage.withLink(link),
      ),
      (Route<dynamic> route) => false);
}
