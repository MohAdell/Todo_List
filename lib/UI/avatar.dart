import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

File? avatarImage;
void Avatar(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
// Pick an image.
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    AssetImage("assets/image/anonymous_Avatar.jpg");
  }
  var myFile = File('$avatarImage');
  avatarImage = image as File?;
  // setState(() {});
}

Widget bottomCamera() {
  return Container(
    height: 130,
    // width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Column(
      children: [
        Text(
          "Choose Profile Pic",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Avatar(ImageSource.camera);
              },
              child: Icon(
                Icons.camera,
                size: 50,
              ),
            ),
            SizedBox(
              width: 50,
            ),
            FloatingActionButton(
              onPressed: () {
                Avatar(ImageSource.gallery);
              },
              child: Icon(
                Icons.image,
                size: 50,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
