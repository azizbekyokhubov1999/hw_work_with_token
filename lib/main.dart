import 'package:flutter/material.dart';
import 'package:hw_work_with_token/pages/home_page.dart';
import 'package:hw_work_with_token/pages/login_page.dart';
import 'package:hw_work_with_token/pages/sign_up_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox<String>('user_token_box');
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login_page',
      routes: {
        '/login_page' : (context) => const  LoginPage(),
        '/sign_up_page' : (context) => const SignUpPage(),
        '/home_page' : (context) => const HomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}