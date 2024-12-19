import 'package:flutter/material.dart';
import 'package:products_sample_app/screens/home_screen.dart';
import 'package:products_sample_app/screens/login_screen.dart';
import 'package:products_sample_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: authService.readToken(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) return const Text("No data");

          if (snapshot.data == "") {
            Future.microtask(
              () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(seconds: 0),
                    pageBuilder: (_, __, ___) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            );
          } else {
            Future.microtask(
              () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(seconds: 0),
                    pageBuilder: (_, __, ___) {
                      return const HomeScreen();
                    },
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
