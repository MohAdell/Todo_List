import 'package:flutter/material.dart';

class DefaultFromFiled extends StatelessWidget {
  TextEditingController controller;
  String? Function(String?)? valid;
  TextInputType? Keyboard;
  String? hint;
  Widget? suffixIcon;
  void Function()? onTap;
  DefaultFromFiled(
      {super.key,
      required this.controller,
      required this.valid,
      this.Keyboard,
      this.hint,
      this.suffixIcon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: valid,
      keyboardType: Keyboard,
      onTap: onTap,
      decoration: InputDecoration(
          hintText: hint,
          suffix: suffixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
