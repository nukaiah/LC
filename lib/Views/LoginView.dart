import 'package:flutter/material.dart';
import 'package:lc/Controllers/AuthenticationController.dart';
import 'package:lc/Utils/AppColors.dart';
import 'package:lc/Utils/MySlivers.dart';
import 'package:lc/Utils/InputFields.dart';
import 'package:lc/Utils/TextStyles.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisible = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthenticationController>(
      builder: (context,authCtrl,child) {
        return Scaffold(
          body: Container(
              height: size.height,
              width: size.width,
              color: scaffoldbackgroundcolor,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: AutofillGroup(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkwuvoWMhl6YAb-8BWrKD1JN5NKA6qe9rHVQfXQKNAVbmSeAKTPeJ8KGzusoTuWC25OX4&usqp=CAU"),
                        Gap(h: 10.0),
                        Text("Welcome Back!",
                            style: TxtStls.stl20,
                            textAlign: TextAlign.center),
                        Gap(h: 10.0),
                        EmailField(
                          controller: emailController,
                          labelText: 'Email',
                          hintText: 'Enter your email id',
                        ),
                        Gap(h: 20.0),
                        PasswordField(
                          isVisible: isVisible,
                          controller: passwordController,
                          labelText: 'Password',
                          hintText: 'Enter Your Password',
                          onPressed: (){
                            isVisible=!isVisible;
                            setState(() {});
                          }
                        ),
                        Gap(h: 20.0),
                        MyButton(
                          context,
                          load: authCtrl.loginLoading,
                          title: "Login",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              authCtrl.Login(context,email:emailController.text.toString() ,password:passwordController.text.toString());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ))
        );
      }
    );
  }
}
