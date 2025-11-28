import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatDialog extends StatelessWidget {
  final String contactName;
  final String text;
  final String time;
  final bool userTypo;
  const ChatDialog({
    super.key, required this.contactName, required this.text, required this.time, required this.userTypo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: userTypo==true? MainAxisAlignment.end:MainAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: userTypo==true? Color(0xff154D71): Color(0xff1C6EA4 ),
                  borderRadius: BorderRadius.circular(15)
              ),

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contactName, style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width:180,
                            child: Text(text, style: GoogleFonts.poppins(fontSize: 23, color: Colors.white),)),
                        SizedBox(width: 10,),
                        Text(time, style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),),

                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}