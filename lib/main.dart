// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:mvvm_/Utils/Routes/routes.dart';
import 'package:mvvm_/Utils/Routes/routesname.dart';
import 'package:mvvm_/View/homescreen.dart';
import 'package:mvvm_/ViewModel/authviewmodel.dart';
import 'package:mvvm_/ViewModel/userviewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>AuthViewModel()),
      ChangeNotifierProvider(create: (_)=>UserViewModel())
    ],child:  MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute
    ),);
  }
}