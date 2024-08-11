import 'package:flutter/material.dart';
import 'package:mvvm_/Utils/Routes/routesname.dart';
import 'package:mvvm_/View/homescreen.dart';
import 'package:mvvm_/View/loginscreen.dart';
import 'package:mvvm_/View/signUpView.dart';
import 'package:mvvm_/View/splashview.dart';

class Routes {
  
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.home:
      return MaterialPageRoute(builder: (context)=>HomeScreen());
      case RoutesName.login: return MaterialPageRoute(builder: (context)=>LoginView());
      case RoutesName.signUp: return MaterialPageRoute(builder: (context)=>SignUpScreen());
      case RoutesName.splash: return MaterialPageRoute(builder: (context)=>SplashScreen());
      default: return MaterialPageRoute(builder: (_){
        return Scaffold(
          body: Center(
            child: Text("No Routes Defined"),
          ),
        );
      });
    }
  }
}