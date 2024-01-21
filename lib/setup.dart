import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hw_work_with_token/services/locale_storage.dart';

import 'my_app.dart';

String? token;
Future<void> checkStorage() async{
token = await AppStorage.read(StorageKey.token);
log("=== $token ====");
}

void setup(){
  WidgetsFlutterBinding.ensureInitialized();
  checkStorage().then((value) {
    runApp(const MyApp());
  });
}
