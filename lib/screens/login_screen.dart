import 'package:flutter/material.dart';
import 'package:products_sample_app/providers/login_form_provider.dart';
import 'package:provider/provider.dart';

import 'package:products_sample_app/ui/input_decorations.dart';
import 'package:products_sample_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text("Login",
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_) {
                        return LoginFormProvider();
                      },
                      child: const _LoginForm(),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Text("Crea una  nueva cuenta",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              loginForm.email = value;
            },
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? "")
                  ? null
                  : "El correo no es correcto";
            },
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInpuDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'correo',
                prefixIcon: const Icon(Icons.alternate_email_sharp)),
          ),
          const SizedBox(height: 30),
          TextFormField(
            onChanged: (value) {
              loginForm.password = value;
            },
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : "La contraseña debe de ser de 6 digitos";
            },
            obscureText: true,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInpuDecoration(
                hintText: '******',
                labelText: 'contraseña',
                prefixIcon: const Icon(Icons.lock_outline)),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            onPressed: () {
              if (!loginForm.isValidForm()) return;
              Navigator.pushReplacementNamed(context, "home");
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: const Text(
                "Ingresar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
