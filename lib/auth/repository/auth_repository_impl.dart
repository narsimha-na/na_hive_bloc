import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:na_hive_bloc/auth/data/auth_data.dart';
import 'package:na_hive_bloc/auth/repository/auth_repository.dart';
import 'package:na_hive_bloc/auth/models/user.dart' as custom_user;

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FirebaseDatabase firebaseDb;

  AuthRepositoryImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.firebaseDb,
  });

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required int phoneNumber,
  }) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() {
        DatabaseReference dbReference = firebaseDb.ref().child('users');

        dbReference
            .child(FirebaseAuth.instance.currentUser!.uid.toString())
            .set(custom_user.User(
              uid: FirebaseAuth.instance.currentUser!.uid.toString(),
              email: email,
              name: name,
              phoneNumber: phoneNumber,
              password: password,
            ).toMap());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak');
      } else {
        throw Exception('error : ${e.toString()}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() {
        firebaseDb
            .ref()
            .child('users')
            .child(FirebaseAuth.instance.currentUser!.uid)
            .once()
            .then((DatabaseEvent snap) {
          log("User Data :  ${snap.snapshot.value.runtimeType}");
          custom_user.User userCutom =
              custom_user.User.fromMap(snap.snapshot.value!);
          UserAuthData().storeUserData(token: userCutom.uid);
          UserAuthData().getUserData().then(
                (value) => log("data : $value"),
              );
          log("User Data : ${userCutom.toString()} ${snap.snapshot.value.toString()}");
        }).catchError((error) {
          print('Error retrieving data: ${error.toString()}');
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No User found for that email');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user');
      } else {
        throw Exception('somthing went wron pleasse try again !');
      }
    } catch (e) {
      throw Exception('Somthing went please try again !');
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception("Somthing went wrong please try again !");
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
