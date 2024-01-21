import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hw_work_with_token/pages/home_page.dart';
import 'package:hw_work_with_token/services/locale_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const id = '/login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

   TextEditingController usernameController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   bool isLoading = true;

  // Future<void> loginUser() async {
  //   final url = Uri.parse('https://dummyjson.com/auth/login');
  //   final response = await http.post(url, body: {
  //     'username': usernameController.text,
  //     'password': passwordController.text,
  //   });
  //
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     final String userToken = responseData['token'];
  //
  //     final Box<String> hiveBox = await Hive.openBox<String>('user_token_box');
  //     await hiveBox.put('user_token', userToken);
  //     Navigator.pushReplacementNamed(context, '/home_page');
  //   } else {
  //     print('Login failed. Status code: ${response.statusCode}');
  //     const AlertDialog(
  //       content: Text('Login failed'),
  //     );
  //   }
  // }

   Future<void> check(String name, String password) async{
     isLoading = false;
     final url = Uri.parse('https://dummyjson.com/auth/login');
     final response = await http.post(url, body: {
        'username': name,
        'password': password,
        });
     if(name.isNotEmpty && password.isNotEmpty){
       await AppStorage.write(StorageKey.token, "userToken").then((value) {
         isLoading = true;
       });
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ?
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const  Row(
              children: [
                 Text(
                  'Login / ',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                 Text(
                  'Sign up ',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () async {
                    await check(usernameController.text, passwordController.text).then((value){
                      if(isLoading){
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Muvofaqiyatli kirildi")
                            ));
                        Navigator.pushReplacementNamed(context, HomePage.id);
                      }
                    });
                  },
                  color: Colors.blue,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  minWidth: 142,
                  height: 44,
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ) : const Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}
