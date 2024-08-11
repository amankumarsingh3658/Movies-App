import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mvvm_/Models/usermodel.dart';

class UserViewModel with ChangeNotifier {
  
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final token = sp.getString('token');
    print(sp.get('token'));
    return UserModel(token: token.toString());
  }

  Future removeUser() async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    sp.clear();
    print(sp.get('token'));
    notifyListeners();
  }
}