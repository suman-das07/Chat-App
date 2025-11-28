import 'package:chat_app/UI/chat_screen.dart';
import 'package:chat_app/UI/signup_page.dart';
import 'package:chat_app/shared_preference.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final DataStore datastore= Get.put(DataStore());
  final LoginController logincontrol = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: SingleChildScrollView(
            child: AutofillGroup(
              child: Column(
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/login.json',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Chatter",
                    style: GoogleFonts.poppins(fontSize: 50, color: Colors.green),
                  ),
                  CustomTextField(
                    controller: logincontrol.email,
                    autofillhints: [AutofillHints.email],
                    text: 'Email',
                    prefixicon: Icon(Icons.email_rounded),
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  Obx(
                    () => CustomTextField(
                      controller: logincontrol.password,
                      text: 'Password',
                      autofillhints: [AutofillHints.password],
                      prefixicon: Icon(Icons.lock),
                      suffixicon: GestureDetector(
                        onTap: () {
                          logincontrol.obscureText.value =
                              !logincontrol.obscureText.value;
                        },
                        child: logincontrol.obscureText.value
                            ? Icon(Icons.remove_red_eye_outlined)
                            : Icon(Icons.remove_red_eye),
                      ),
                      obscureText: logincontrol.obscureText.value,
                    ),
                  ),
                  SizedBox(height: 25),
                Obx(()=>  CustomButton(
                    title: 'Login',
                    textcolor: Colors.white,
                    color: Colors.blue,
                    active: logincontrol.isloading.value,

                    onTap: () {
                      logincontrol.login();

                    },
                  ),
                ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SignupPage());
                    },
                    child: Text(
                      "Don\'t have an account? Sign Up",
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "Made With 🧠 by Suman Das",
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
