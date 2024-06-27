import 'package:flutter/material.dart';
import 'package:lc/Controllers/AuthenticationController.dart';
import 'package:lc/Utils/AppColors.dart';
import 'package:lc/Utils/InputFields.dart';
import 'package:lc/Utils/MySlivers.dart';
import 'package:lc/Utils/TextStyles.dart';
import 'package:provider/provider.dart';


class ForgorPasswordView extends StatefulWidget {
  const ForgorPasswordView({super.key});

  @override
  State<ForgorPasswordView> createState() => _ForgorPasswordViewState();
}

class _ForgorPasswordViewState extends State<ForgorPasswordView> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthenticationController>(
      builder: (context,authCtrl,child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: scaffoldbackgroundcolor,
            elevation: 0.0,
            scrolledUnderElevation: 0.0,
            leading: IconButton(icon:const Icon(Icons.arrow_back_ios_new),onPressed: (){Navigator.pop(context);},),
          ),
          body: Form(
            key: _formKey,
            child: SafeArea(
              child: Container(
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkwuvoWMhl6YAb-8BWrKD1JN5NKA6qe9rHVQfXQKNAVbmSeAKTPeJ8KGzusoTuWC25OX4&usqp=CAU"),
                    Gap(h: 10.0),
                    Text("Forgot Password",
                        style: TxtStls.stl20,
                        textAlign: TextAlign.center),
                    Gap(h: 10.0),
                    EmailField(
                      controller: emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email id',
                    ),
                    Gap(h: 20.0),
                    MyButton(
                      context,
                      load: authCtrl.forgotLoad,
                      title: "Forgot Password",
                      onTap: () {
                        print("object");
                        if (_formKey.currentState!.validate()) {
                          authCtrl.ForgotPassword(context,email:emailController.text.toString());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
