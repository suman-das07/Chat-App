import 'package:chat_app/UI/chat_screen.dart';
import 'package:chat_app/UI/landing_page.dart';
import 'package:chat_app/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override

  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  final LoginController loginController= Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), (){
      print(loginController.usertype);
    if(loginController.usertype.value=="login"){

      Get.off(()=> ChatScreen());
    }
    else{
      Get.off(()=> LandingPage());
    }
    });
    return Scaffold(
         body: Center(
           child: Lottie.asset('assets/Chat.json', fit: BoxFit.cover, height: 200),
         ),
    );
  }
}
