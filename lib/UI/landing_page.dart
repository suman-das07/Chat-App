import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/UI/login_page.dart';
import 'package:chat_app/UI/signup_page.dart';
import 'package:chat_app/controllers/login_controller.dart';
import 'package:chat_app/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../widgets/custom_button.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  final logincontroller= Get.put(LoginController());
  final datastore= Get.put(DataStore());
  String email='';
  String password='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset(
                  'assets/Chatting Illustration.json',
                  fit: BoxFit.cover,
                  height: 300,
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Chatter",
                style: GoogleFonts.poppins(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 20,
                // width: 250.0,
                child: DefaultTextStyle(
                  style: const TextStyle(fontSize: 18.0, fontFamily: "poppins", color: Colors.black),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'world\'s most private chatting app'.toUpperCase(),
                        speed: Duration(milliseconds: 100),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
              ),
              SizedBox(height: 40,),
              GestureDetector(
                onTap: () {
                   Get.to(()=>LoginPage());
                },
                  child: CustomButton(title: "login", textcolor: Colors.blue, bordercolor: Colors.blue,)),
              SizedBox(height: 20,),
              GestureDetector(
                child: GestureDetector(
                    onTap: () {
                      Get.to(()=>SignupPage());
                    },
                  child: CustomButton(title: "signup",color: Colors.pink, textcolor: Colors.white,)),
              ) ],

          ),
        ),
      ),
    );
  }
}

