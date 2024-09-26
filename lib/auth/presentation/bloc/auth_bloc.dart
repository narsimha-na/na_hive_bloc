import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:na_hive_bloc/auth/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signUp(
          email: event.email,
          password: event.password,
          name: event.name,
          phoneNumber: event.phoneNo,
        );
        emit(Authenticated());
      } catch (e) {
        log("Error: ${e.toString()}");
        emit(AuthError(error: e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signIn(
          email: event.email,
          password: event.password,
        );
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(error: e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<GoogleSignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signInWithGoogle();
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(error: e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signOut();
        emit(UnAuthenticated());
      } catch (e) {
        emit(AuthError(error: e.toString()));
        emit(UnAuthenticated());
      }
    });
  }
}
