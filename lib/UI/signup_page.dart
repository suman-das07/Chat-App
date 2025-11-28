import 'package:chat_app/UI/login_page.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../controllers/signup_controller.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final SignupController signupController = Get.put(SignupController());
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset(
                    'assets/login.json',
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Chatter",
                  style: GoogleFonts.poppins(fontSize: 50, color: Colors.green),
                ),
                CustomTextField(
                  controller: name,

                  text: "Name",
                  prefixicon: Icon(Icons.text_format),
                  obscureText: false,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: email,
                  text: 'Email',
                  prefixicon: Icon(Icons.email_rounded),
                  obscureText: false,
                ),
                SizedBox(height: 15),
                Obx(
                  () => CustomTextField(
                    controller: password,
                    text: 'Password',
                    prefixicon: Icon(Icons.lock),
                    suffixicon: GestureDetector(
                      onTap: () {
                        signupController.obscureText.value =
                            !signupController.obscureText.value;
                      },
                      child: signupController.obscureText.value
                          ? Icon(Icons.remove_red_eye_outlined)
                          : Icon(Icons.remove_red_eye),
                    ),
                    obscureText: signupController.obscureText.value,
                  ),
                ),
                SizedBox(height: 20),
               Obx(()=> CustomButton(
                  active: signupController.isloading.value,
                  title: 'SignUp',
                  textcolor: Colors.white,
                  color: Colors.blue,
                  onTap: () {
                    signupController.signup(
                      email.text,
                      password.text,
                      name.text,
                    );
                  },
                ),
               ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(() => LoginPage());
                  },
                  child: Text(
                    "Or Log In instead",
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Made With 🧠 by Suman Das",
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
