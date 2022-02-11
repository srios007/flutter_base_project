import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final String label;
  final Color? color;
  final Color textColor;
  final VoidCallback onPressed;

  const SimpleButton({
    Key? key,
    required this.label,
    this.color,
    this.textColor = Colors.white,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: Text(
        'Login',
        style: TextStyle(color: textColor),
      ),
    );
  }
}
