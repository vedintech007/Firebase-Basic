import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learn_firebase/dismis_keyboard.dart';
import 'package:learn_firebase/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const DismissKeyboard(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Learn Firebase',
        home: MainPage(),
      ),
    );
  }
}
