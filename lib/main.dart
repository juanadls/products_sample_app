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
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.indigo, elevation: 0),
          appBarTheme: const AppBarTheme(elevation: 0, color: Colors.indigo)),
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
