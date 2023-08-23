import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final double fontsize;
  final Color? color;
  final int? maxLines;
  const TitleWidget(
      {required this.title, this.fontsize = 20, this.color, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      style: TextStyle(
          color: color,
          fontSize: fontsize,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis),
    );
  }
}
