import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({super.key, this.PickedImage, required this.ftc});

  final XFile? PickedImage;
  final Function ftc;

  @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: PickedImage == null
                ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  )
                : Image.file(
                    File(PickedImage!.path),
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        Positioned(
            top: 0,
            right: 0,
            child: Material(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  splashColor: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    ftc();
                  },
                  child: const Icon(
                    Icons.photo_camera_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
