// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:mvvm_/Models/usermodel.dart';
import 'package:mvvm_/Resources/Components/colors.dart';
import 'package:mvvm_/Resources/Components/roundbutton.dart';
import 'package:mvvm_/Utils/Routes/routesname.dart';
import 'package:mvvm_/Utils/generalutils.dart';
import 'package:mvvm_/ViewModel/Services/splashservices.dart';
import 'package:mvvm_/ViewModel/authviewmodel.dart';
import 'package:mvvm_/ViewModel/userviewmodel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  ValueNotifier<bool> obscure = ValueNotifier(true);
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordcontroller.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    obscure.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final userviewmodel = Provider.of<UserViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Login"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  focusNode: emailFocusNode,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      )),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, emailFocusNode, passwordFocusNode);
                  },
                ),
                ValueListenableBuilder(valueListenable: obscure, builder: ((context, value, child) {
                  return TextFormField(
                  focusNode: passwordFocusNode,
                  controller: passwordcontroller,
                  obscureText: obscure.value,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          obscure.value = !obscure.value;
                        },
                        child: obscure.value ? Icon(Icons.visibility) : Icon(Icons.visibility_off))),
                  );
                })),
                SizedBox(height: height*0.05,),
                RoundButton(
                  title: 'Login',
                  loading: authViewModel.loading,
                  onPress: (){
                  if (emailController.text.isEmpty) {
                    Utils.flushBarErrorMessages("Please Enter Email", context);
                  }
                  else if (passwordcontroller.text.isEmpty) {
                    Utils.flushBarErrorMessages("Please Enter Password", context);
                  }
                  else if (passwordcontroller.text.length < 8) {
                    Utils.flushBarErrorMessages("Password Cannot Be Less Than 8 Digits", context);
                  }
                  else{
                    Map data = {
                      'email' : emailController.text.toString(),
                      'password' : passwordcontroller.text.toString()
                    };
                    userviewmodel.saveUser(UserModel());
                    authViewModel.loginApi(data,context);
                  }
                },color: AppColors.teal,),
                SizedBox(height: height*0.02,),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.signUp);
                  },
                  child: Text("Don't Have an Account? SignUp"))
              ],
            ),
          )),
    );
  }
}
