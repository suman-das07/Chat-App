import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({

    super.key, required this.title, this.color, required this.textcolor, this.bordercolor, this.onTap, this.active,

  });
  final String title;
  final Color? color;
  final Color textcolor;
  final Color? bordercolor;
  final bool? active;
final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:active==true?null: onTap ,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border:bordercolor==null?null: Border.all(color: bordercolor!),
            color: color==null?null: color,
        ),
        child: Center(child: active==true? Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            height: 25,
              width: 25,
              child: CircularProgressIndicator(color: Colors.white,)),
        ): Text(title.toUpperCase(), style: GoogleFonts.poppins(fontSize: 20, color: textcolor, ))),
      ),
    );
  }
}
