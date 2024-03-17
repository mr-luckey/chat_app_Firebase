import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function(String) onSaved;
  final String regEx;
  final String hintText;
  final bool obscureText;
  final IconData? suffixIcon;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.onSaved,
    required this.regEx,
    required this.obscureText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (_value) => onSaved(_value!),
      cursorColor: Colors.white,
      obscureText: obscureText,
      validator: (_value) {
        return RegExp(regEx).hasMatch(_value!)
            ? null
            : 'Please enter a valid $hintText';
      },
      // (_value) {
      //   if (_value!.isEmpty) {
      //     return 'Please enter $hintText';
      //   }
      //   if (regEx.isNotEmpty) {
      //     if (!RegExp(regEx).hasMatch(_value!)) {
      //       return 'Please enter a valid $hintText';
      //     }
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
        fillColor: Color.fromRGBO(30, 29, 37, 1.0),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        labelStyle: TextStyle(color: Colors.white),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: () {}, // Implement toggle password visibility
                icon: Icon(suffixIcon, color: Colors.white), // Set icon color
              )
            : null,
      ),
      style: TextStyle(color: Colors.white), // Set text color
    );
  }
}
