import 'package:e_commerce/screens/search_screen.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';

import 'package:flutter/material.dart';

class CategoriesRoundedWidget extends StatelessWidget {
  const CategoriesRoundedWidget(
      {super.key, required this.image, required this.name});
  final String image, name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(
          context,
          SearchScreen.routeName,
          arguments: name,
        );
      },
      child: Column(
        children: [
          Image.asset(
            image,
            height: 50,
            width: 50,
          ),
          const SizedBox(
            height: 18,
          ),
          SubTitlewidget(
            title: name,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
