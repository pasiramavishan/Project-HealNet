import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:healnet/authentication/signup_screen.dart';
//import 'package:healnet/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDH209QuQ6PoXS1ogyQlsuMj9iM-sW_qOo',
      appId: '1:235891692608:android:488e0d70c8e5856ad7bba5',
      messagingSenderId: '235891692608',
      projectId: 'healnet-661e8',
      storageBucket: 'healnet-661e8.appspot.com',
    )
  );runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HealNet",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SignUpScreen(), // Ensure SignUpScreen is a StatelessWidget or StatefulWidget
    );
  }
}
