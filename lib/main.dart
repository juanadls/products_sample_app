import 'package:flutter/material.dart';
import 'package:products_sample_app/screens/home_screen.dart';
import 'package:products_sample_app/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Products Sample APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "login",
      routes: {
        "login": (_) {
          return const LoginScreen();
        },
        "home": (_) {
          return const HomeScreen();
        }
      },
    );
  }
}
