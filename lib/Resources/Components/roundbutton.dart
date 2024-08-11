
// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:mvvm_/Resources/Components/colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  final Color color;
  RoundButton(
      {super.key,
      required this.title,
      required this.loading,
      required this.onPress,
      this.color = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: color),
        height: 50,
        width: 200,
        child: Center(
            child: loading ? CircularProgressIndicator(color: Colors.white,) : Text(title,
                style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20 ))),
      ),
    );
  }
}
