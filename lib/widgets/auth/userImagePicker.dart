import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;

  const UserImagePicker(this.imagePickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  late File _pickedImage = File('');
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey,
        backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
      ), // circleAvatar
      const SizedBox(height: 18),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        TextButton.icon(
          onPressed: () => pickImage(ImageSource.camera),
          icon: const Icon(Icons.photo_camera_outlined),
          label: Text('Add Image\nfrom Camera',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              )),
        ),
        TextButton.icon(
          onPressed: () => pickImage(ImageSource.gallery),
          icon: const Icon(Icons.image_outlined),
          label: Text('Add Image\nfrom Gallery',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center),
        ),
      ]), // Row
    ] // widget>[]
        ); // Column
  }

  void pickImage(ImageSource src) async {
    final pickedImageFile =
        await picker.pickImage(source: src, imageQuality: 50);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.imagePickFn(_pickedImage);
    } else {
      print('No Image Selected');
    }
  }
}
