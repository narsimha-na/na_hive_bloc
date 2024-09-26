import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:na_hive_bloc/auth/presentation/bloc/auth_bloc.dart';
import 'package:na_hive_bloc/auth/presentation/auth_page.dart';
import 'package:na_hive_bloc/auth/repository/auth_repository_impl.dart';
import 'package:na_hive_bloc/firebase_options.dart';
import 'package:na_hive_bloc/home/presentation/bloc/crud_bloc.dart';
import 'package:na_hive_bloc/home/models/transactions.dart' as trans;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  Hive.registerAdapter(trans.TransactionAdapter());
  await Hive.openBox<trans.Transaction>('transactions');

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  AuthRepositoryImpl authRepo = AuthRepositoryImpl(
    firebaseAuth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(),
    firebaseDb: FirebaseDatabase.instance,
  );

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => authRepo,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepository: authRepo),
          ),
          BlocProvider<CrudBloc>(
            create: (context) => CrudBloc(),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Color.fromARGB(255, 241, 241, 241),
            body: Center(
              child: AuthPage(),
            ),
          ),
        ),
      ),
    );
  }
}
