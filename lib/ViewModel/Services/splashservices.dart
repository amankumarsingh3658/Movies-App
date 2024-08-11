import 'package:flutter/material.dart';
import 'package:mvvm_/Models/usermodel.dart';
import 'package:mvvm_/Utils/Routes/routesname.dart';
import 'package:mvvm_/ViewModel/userviewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {
  Future<UserModel> getUserdata() => UserViewModel().getUser();
  
  void checkAuthentication(context) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    getUserdata().then((value) async {
      if (value.token == sp.getString('token')) {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }else{
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      }
    }).onError((error, stackTrace){
      print(error.toString());
    });
  }  
} 