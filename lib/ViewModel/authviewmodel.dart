import 'package:flutter/material.dart';
import 'package:mvvm_/Data/app_exceptions.dart';
import 'package:mvvm_/Repositories/authrepository.dart';
import 'package:mvvm_/Utils/Routes/routesname.dart';
import 'package:mvvm_/Utils/generalutils.dart';

class AuthViewModel with ChangeNotifier {
  
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading; 

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignupLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      Utils.flushBarErrorMessages("Login Successful", context);
      setLoading(false);
      Navigator.pushNamed(context,RoutesName.home);
      print(value.toString());
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessages(error.toString(), context);
      setLoading(false);
      print(error.toString()); 
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSignupLoading(true);
    _myRepo.signUpApi(data).then((value){
      Utils.flushBarErrorMessages("SignUp Succesfull", context);
      print(value.toString());
      Navigator.pushNamed(context, RoutesName.home);
      setSignupLoading(false);
    }).onError((error, stackTrace){
      Utils.flushBarErrorMessages(error.toString(), context);
      setSignupLoading(false);
    });
  }
}
