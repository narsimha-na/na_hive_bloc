import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_hive_bloc/auth/presentation/bloc/auth_bloc.dart';
import 'package:na_hive_bloc/constants/buttons_helper.dart';
import 'package:na_hive_bloc/constants/color_helper.dart';
import 'package:na_hive_bloc/home/presentation/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is Authenticated) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return _loginPageWidget(state);
          },
        ),
      ),
    );
  }

  _loginPageWidget(state) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login Page',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 16,
                ),
              ),
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        8,
                      ),
                    ),
                  ),
                  hintText: "Email",
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: passwordCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        8,
                      ),
                    ),
                  ),
                  hintText: "Password",
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 16,
                ),
              ),
              PrimaryButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(
                    SignInRequested(
                      email: emailCtrl.text,
                      password: passwordCtrl.text,
                    ),
                  );
                },
                label: 'Login',
              )
            ],
          ),
        ),
      );
}
