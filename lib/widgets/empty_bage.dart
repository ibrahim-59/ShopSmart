import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class EmptyBagScreen extends StatelessWidget {
  final String image, title, subtitle, textbutton;
  const EmptyBagScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.textbutton});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            image,
            height: size.height * 0.35,
            width: double.infinity,
          ),
          const TitleWidget(
            title: 'Whoops !',
            fontsize: 40,
            color: Colors.red,
          ),
          const SizedBox(
            height: 20,
          ),
          SubTitlewidget(
            title: title,
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SubTitlewidget(
              title: subtitle,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  elevation: 0,
                  backgroundColor: Colors.red),
              onPressed: () {},
              child: Text(
                textbutton,
                style: const TextStyle(fontSize: 22),
              ))
        ],
      ),
    ));
  }
}
