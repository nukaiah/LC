import 'package:flutter/material.dart';
import 'package:lc/Controllers/AppointmentController.dart';
import 'package:lc/Controllers/AuthenticationController.dart';
import 'package:lc/Controllers/CameraController.dart';
import 'package:lc/Views/ChangePasswordView.dart';
import 'package:lc/Views/SplashView.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx)=>AuthenticationController()),
        ChangeNotifierProvider(create: (ctx)=>AppointmentController()),
        ChangeNotifierProvider(create: (ctx)=>CameraOpenController()),
      ],
      child: const MyApp(),
    )
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView()
    );
  }
}
