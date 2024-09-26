import 'package:flutter/material.dart';
import 'package:na_hive_bloc/auth/presentation/login_page.dart';
import 'package:na_hive_bloc/auth/presentation/singup_page.dart';
import 'package:na_hive_bloc/constants/buttons_helper.dart';
import 'package:na_hive_bloc/constants/color_helper.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Auth Page",
              style: TextStyle(
                fontSize: 42,
                color: primaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: Column(
                children: [
                  PrimaryButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    label: 'Login',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SecondaryButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingUpPage(),
                        ),
                      );
                    },
                    label: 'Sing Up',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  primaryButton({required Function onPressed, required String label}) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF161D6F),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
