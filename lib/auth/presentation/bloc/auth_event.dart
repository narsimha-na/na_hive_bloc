part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({required this.email, required this.password});
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final int phoneNo;

  const SignUpRequested({
    required this.email,
    required this.password,
    required this.name,
    required this.phoneNo,
  });
}

class GoogleSignInRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}
