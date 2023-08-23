import 'package:e_commerce/services/assets_manager.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class MyAppMethods {
  static Future<void> showErrorOrWaringDialog({
    required BuildContext context,
    required String subTitle,
    required Function ftc,
    bool isError = true,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Image.asset(
                AssetsManager.warning,
                width: 60,
                height: 60,
              ),
              const SizedBox(
                height: 16,
              ),
              SubTitlewidget(
                title: subTitle,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: !isError,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const SubTitlewidget(
                          title: 'Cancel',
                          color: Colors.green,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        ftc();
                        Navigator.pop(context);
                      },
                      child: const SubTitlewidget(
                        title: 'OK',
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              )
            ]),
          );
        });
  }

  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function cameraFct,
    required Function gallaryFct,
    required Function removeFct,
  }) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Center(
              child: TitleWidget(title: 'Choose an option'),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      cameraFct();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.grey,
                    ),
                    label: const Text('Camera'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      gallaryFct();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.image,
                      color: Colors.grey,
                    ),
                    label: const Text('Gallary'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      removeFct();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.grey,
                    ),
                    label: const Text('Remove'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
