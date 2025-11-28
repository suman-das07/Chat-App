import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore extends GetxController{

 Future <void> savelogin(
  String email,
  String password) async{
   final preference= await SharedPreferences.getInstance(
   );
  await preference.setString(email, email);
  await preference.setString(password, password);
  }

  Future <Map<String,dynamic>> getlogin()async {
    final preference = await SharedPreferences.getInstance();
    await preference.getString("email");
    await preference.getString("password");
    return {"email": await preference.getString("email").toString()
      , "password": await preference.getString("password").toString()};
  }

  Future <void> clearlogin(
      String email,
      String password
      )async{
   final preference = await SharedPreferences.getInstance();
   await preference.remove(email);
   await preference.remove(password);

  }

}