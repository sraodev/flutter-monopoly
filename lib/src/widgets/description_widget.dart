import 'package:flutter/material.dart';
import 'package:monopoly/colors.dart' as AppColors;

class Description extends StatelessWidget {
  Description({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        color: AppColors.descriptionTextColor,
        height: 1.4,
      ),
    );
  }
}
