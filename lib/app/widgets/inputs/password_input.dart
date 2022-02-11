import 'package:flutter/material.dart';
import '../../tools/tools.dart';

class PasswordInput extends StatelessWidget {
  final VoidCallback onChanged;
  final VoidCallback onSaved;

  const PasswordInput(
      {Key? key, required this.onChanged, required this.onSaved})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (x) => onChanged,
      onSaved: (x) => onSaved,
      validator: validatePassword,
      obscureText: true,
      style: TextStyle(color: colors.textColor, fontSize: 14),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colors.textColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red[700]!),
        ),
        focusColor: Colors.white,
        hintText: "Password",
        hintStyle: TextStyle(color: colors.textColor, fontSize: 14),
      ),
    );
  }
}
