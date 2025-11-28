import 'package:chat_app/UI/custom_drawer.dart';
import 'package:chat_app/controllers/chat_controller.dart';
import 'package:chat_app/widgets/chat_dialog.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final ChatController chatController = Get.put(ChatController());
  final TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String timeFunction(String time) {
      DateTime dateTime = DateTime.parse(time);

      var formattedTime = DateFormat("hh:mm a").format(dateTime);
      return formattedTime;
    }


    return Scaffold(
      key: chatController.scaffoldkey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            color: Colors.blue.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      chatController.opendrawer();
                    },
                    child: Icon(
                      Icons.menu_rounded,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chatter",
                        style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "By Suman Das",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      drawer: CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("messages")
                  .orderBy("time", descending: false)
                  .snapshots(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.hasError) {
                  Get.snackbar("Failed to send Message", "Try again!");
                }
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                var data = asyncSnapshot.data;

                List<dynamic> messages = data!.docs;

                return ListView.builder(
                  itemCount: messages.length,
                  controller: chatController.scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    var message = messages[index];
                    return ChatDialog(
                      contactName: message["username"] ?? "",
                      text: message["text"],
                      time: timeFunction(message["time"]),
                      userTypo:
                          FirebaseAuth.instance.currentUser!.email ==
                          message["mail"],
                    );
                  },
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // shadow color
                  blurRadius: 13, // softness of the shadow
                  spreadRadius: 0.8, // how wide the shadow spreads
                  offset: Offset(0, 0), // horizontal, vertical offset
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: text,
                text: "Type a  Message",
                prefixicon: Icon(Icons.add_a_photo_outlined),
                obscureText: false,
                width: double.infinity,
                enter: (value) {
                  chatController.sendmessage(value);

                  text.clear();
                },
                suffixicon: Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: GestureDetector(
                    onTap: () {
                      if (text.text != "") {
                        chatController.sendmessage(text.text);
                        text.clear();
                        FocusScope.of(context).unfocus();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xff00755E),
                      ),
                      child: Icon(
                        Icons.send_rounded,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
