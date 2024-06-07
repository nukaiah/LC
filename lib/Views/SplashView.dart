import 'package:flutter/material.dart';
import 'package:lc/Controllers/AuthenticationController.dart';
import 'package:lc/Utils/AppColors.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2)).whenComplete((){
      Provider.of<AuthenticationController>(context,listen: false).CheckAuthenticationStatus(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: primarycolor,
        child: const Icon(Icons.people_alt_sharp,size: 100,color: secondarywhite,),
      ),
    );
  }
}
