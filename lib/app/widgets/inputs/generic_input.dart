import 'package:flutter/material.dart';
import '../../tools/tools.dart';

class GenericInput extends StatelessWidget {
  final VoidCallback onChanged;
  final VoidCallback onSaved;
  String hintText;
  TextEditingController controller = TextEditingController();

  GenericInput({
    Key? key,
    required this.onChanged,
    required this.onSaved,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
        hintText: hintText,
        hintStyle: TextStyle(color: colors.textColor, fontSize: 14),
      ),
    );
  }
}
