import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final bool isnum;
  final int lines;
  final String validatorMessage;
  final TextEditingController controller;
  final String hintText; // Tambahkan hintText
  final bool obscureText; // Tambahkan obscureText

  CustomInputField({
    required this.isnum,
    required this.lines,
    required this.validatorMessage,
    required this.controller,
    this.hintText = "", // Default kosong jika tidak diisi
    this.obscureText = false, // Default false jika tidak diisi
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: isnum ? TextInputType.number : TextInputType.text,
      maxLines: lines,
      obscureText: obscureText, // Tambahkan ini agar bisa menyembunyikan teks
      decoration: InputDecoration(
        hintText: hintText, // Tambahkan hintText
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE8E8E8), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMessage;
        }
        if (isnum && double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }
}
