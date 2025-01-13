import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final String? fontFamily;
  final EdgeInsetsGeometry? padding;
  final Color color;

  final dynamic decoration;

  const MyText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    this.padding,
    required this.color,
    this.fontFamily,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Text(text,
          style: TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: fontFamily,
              decoration: decoration)),
    );
  }
}
