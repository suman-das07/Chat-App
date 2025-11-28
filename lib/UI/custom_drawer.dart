import 'package:chat_app/UI/entry_page.dart';
import 'package:chat_app/UI/login_page.dart';
import 'package:chat_app/controllers/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final LoginController loginController= Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(radius: 60,),
              SizedBox(height: 20,),
              Text(FirebaseAuth.instance.currentUser!.displayName.toString(),style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(FirebaseAuth.instance.currentUser!.email.toString(), style: GoogleFonts.poppins( fontSize: 20),),
              Spacer(),
              GestureDetector(
                onTap: (){
                  FirebaseAuth.instance.signOut();
                  Get.offAll(()=> EntryPage());
                  loginController.clearlogin();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff004F98),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(child: Text("Log Out", style: GoogleFonts.poppins(fontSize: 25, color: Colors.white),)),
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
