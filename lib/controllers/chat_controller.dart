import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    scrollController.dispose();
    super.onInit();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ScrollController scrollController= ScrollController();
  final GlobalKey<ScaffoldState> scaffoldkey= GlobalKey<ScaffoldState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  void sendmessage(String text) async {
    var messages = firestore.collection("messages");

    try {

      await messages.add({
        "username": auth.currentUser!.displayName,
        "text": text,
        "mail": auth.currentUser!.email,
        "time": DateTime.now().toString(),
      });
      scrollcontrol();
    } catch (e) {
      Get.snackbar(
        "Failed to Send Message $e",
        "Try again!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void scrollcontrol() async{
   await Future.delayed(Duration(milliseconds: 50),(){
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }
  void opendrawer(){
    scaffoldkey.currentState!.openDrawer();
  }

}
