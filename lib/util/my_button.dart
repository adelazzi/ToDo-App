// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(right:10,left: 10,top: 10),
      decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        onTap: onPressed,
        child: Text(text),
      ),
    );
  }
}
