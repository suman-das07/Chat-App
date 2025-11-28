import 'package:chat_app/UI/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  RxBool obscureText = true.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isloading= false.obs;

  void signup(String email, String password, String name) async {
    isloading.value=true;
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      Get.showSnackbar(
        GetSnackBar(
          title: "Please enter all the fields",
          message: "Try again",
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      try {
     await auth.createUserWithEmailAndPassword(email: email, password: password);
     await auth.currentUser!.updateDisplayName(name);


     Get.offAll(()=> LoginPage());
        Get.showSnackbar(
          GetSnackBar(
            title: "Sign Up successful",
            message: "Welcome",
            duration: Duration(seconds: 2),
            backgroundColor: Colors.lightBlue,


          ),
        );
      } catch (e) {
        Get.showSnackbar(
          GetSnackBar(
            title: "Failed to Sign Up",
            message: e.toString(),
            duration: Duration(seconds: 2),
          ),

        );
      }
      finally{
        isloading.value=false;
      }
    }
  }
}
