import 'package:chat_app/UI/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    autologin();
    super.onInit();
  }
  RxBool isloading= false.obs;
  RxString usertype='firsttimelogin'.obs;
  RxBool obscureText = true.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  void login() async {
    isloading.value=true;
    final preference = await SharedPreferences.getInstance();
    if (email.text.isEmpty || password.text.isEmpty) {
      Get.snackbar(
        "Failed to Log In",
        "Please fill all fields",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isloading.value=false;
    } else {
      try {
        await auth.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        Get.offAll(() => ChatScreen());

        Get.snackbar(
          "Succesfully Loggedin",
          "Welcome",
          backgroundColor: Colors.greenAccent,
          colorText: Colors.white,
          maxWidth: 500,
        );
        usertype.value="login";
        await preference.setString("userState", "login");
        await preference.setString("email", email.text);
        await preference.setString("password", password.text);
        isloading.value=true;

      } catch (e) {
        Get.snackbar(
          "Failed to Log In $e",
          "Try again!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      finally{
        isloading.value=false;
      }
    }
  }

  void autologin() async {
    final preference = await SharedPreferences.getInstance();
    String? state= preference.getString("userState");
    if(state=="login"){
      String? preferenceEmail= preference.getString("email");
      String? preferencePassword= preference.getString("password");
      try{
        if(email!=null || password!=null){
          await auth.signInWithEmailAndPassword(
            email: preferenceEmail!,
            password: preferencePassword!,
          );
          usertype.value="login";
        }
        else{
          usertype.value="firsttimelogin";
        }

      }
      catch(e){
        usertype.value="firsttimelogin";
      }
    }
  }


  Future<void> clearlogin() async {
    final preference = await SharedPreferences.getInstance();
    await preference.setString("userState", "firstimelogin");
    usertype.value="firsttimelogin";
    await preference.remove("email");
    await preference.remove("password");

  }
}

