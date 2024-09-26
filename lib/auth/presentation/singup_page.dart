import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_hive_bloc/auth/presentation/bloc/auth_bloc.dart';
import 'package:na_hive_bloc/constants/buttons_helper.dart';
import 'package:na_hive_bloc/constants/color_helper.dart';

class SingUpPage extends StatefulWidget {
  SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Succesfull Created")));
          }
          if (state is Error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Error")));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'SingUp Page',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    TextField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8,
                            ),
                          ),
                        ),
                        hintText: "Name",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(
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
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: passwordCtrl,
                      decoration: const InputDecoration(
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
                    const Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    PrimaryButton(
                      onPressed: () {
                        createAccountWithEmailAndPassword(context);
                      },
                      label: 'Sing Up',
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  createAccountWithEmailAndPassword(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(
      SignUpRequested(
        email: emailCtrl.text,
        password: passwordCtrl.text,
        name: nameCtrl.text,
        phoneNo: 91235648785,
      ),
    );
  }
}
