import 'package:flutter/material.dart';
import 'package:mvvm_/Resources/Components/colors.dart';
import 'package:mvvm_/Resources/Components/roundbutton.dart';
import 'package:mvvm_/Utils/Routes/routesname.dart';
import 'package:mvvm_/Utils/generalutils.dart';
import 'package:mvvm_/ViewModel/authviewmodel.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
      final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("SignUp"),
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
                  title: 'SignUp',
                  loading: authViewModel.signUpLoading,
                  onPress: (){
                  if (emailController.text.isEmpty) {
                    Utils.flushBarErrorMessages("Please Enter Email", context);
                  }
                  else if (passwordcontroller.text.isEmpty) {
                    Utils.flushBarErrorMessages("Please Enter Password", context);
                  }
                  else if (passwordcontroller.text.length < 6) {
                    Utils.flushBarErrorMessages("Password Cannot Be Less Than 6 Digits", context);
                  }
                  else{
                    Map data = {
                      'email' : emailController.text.toString(),
                      'password' : passwordcontroller.text.toString()
                    };
                    authViewModel.signUpApi(data,context);
                  }
                },color: AppColors.teal,),
                SizedBox(height: height*0.02,),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.login);
                  },
                  child: Text("Already Have an Account? Login"))
              ],
            ),
          )),
    );
  }
} 