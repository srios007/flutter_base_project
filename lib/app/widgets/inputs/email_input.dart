import 'package:flutter/material.dart';
import '../../tools/tools.dart';

class EmailInput extends StatelessWidget {
  final VoidCallback onChanged;
  final VoidCallback onSaved;

  const EmailInput({Key? key, required this.onChanged, required this.onSaved})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validateText,
      onChanged: (x) => onChanged,
      onSaved: (x) => onSaved,
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
        hintText: "Email",
        hintStyle: TextStyle(color: colors.textColor, fontSize: 14),
      ),
    );
  }
}
