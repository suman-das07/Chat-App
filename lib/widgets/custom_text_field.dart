import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final Icon prefixicon;
  final bool obscureText;
  final Widget? suffixicon;
  final double? width;
  final TextEditingController? controller;
  final Iterable<String>? autofillhints;
  const CustomTextField({super.key, required this.text, required this.prefixicon, this.suffixicon, required this.obscureText,   this.controller, this.width=500, this.autofillhints, this.enter});

  final void  Function(String)? enter;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
          border: Border.all(color: Colors.blue)
      ),
      child: TextField(
        textInputAction: TextInputAction.send,
        obscureText: obscureText,
        onSubmitted: enter,
        controller: controller ,
        autofillHints: autofillhints,

        decoration: InputDecoration(
          prefixIcon:prefixicon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
          hint: Text(text),
          suffixIcon: suffixicon,
        ),
      ),
    );
  }
}
