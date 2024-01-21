import 'package:flutter/material.dart';
import 'package:hw_work_with_token/pages/home_page.dart';
import 'package:hw_work_with_token/pages/login_page.dart';
import 'package:hw_work_with_token/setup.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Get token',
      home: token != null ? const HomePage() : const LoginPage(),
      routes: {
        HomePage.id : (context) => const HomePage(),
        LoginPage.id : (context) => const LoginPage(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}