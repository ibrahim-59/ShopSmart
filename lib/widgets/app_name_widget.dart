import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({super.key, this.fontSize = 30});
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.purple,
      highlightColor: Colors.red,
      child: TitleWidget(
        title: 'Shop Smart',
        fontsize: fontSize,
      ),
    );
  }
}
