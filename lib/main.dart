import 'package:flutter/material.dart';
import 'package:products_sample_app/screens/product_screen.dart';
import 'package:products_sample_app/screens/screens.dart';
import 'package:products_sample_app/services/services.dart';
import 'package:provider/provider.dart';

import 'services/notification_service.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return ProductService();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return AuthService();
          },
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: NotificationService.messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Products Sample App',
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
        },
        "product": (_) {
          return const ProductScreen();
        },
        "register": (_) {
          return const RegisterScreen();
        },
        "checkAuth": (_) {
          return const CheckAuthScreen();
        }
      },
    );
  }
}
