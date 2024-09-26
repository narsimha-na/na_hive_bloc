import 'dart:convert';

class User {
  String uid;
  String email;
  String name;
  int phoneNumber;
  String password;

  User({
    required this.uid,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.password,
  });

  User copyWith({
    String? uid,
    String? email,
    String? name,
    int? phoneNumber,
    String? password,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }

  factory User.fromMap(dynamic map) {
    return User(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as int,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap((source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(uid: $uid, email: $email, name: $name, phoneNumber: $phoneNumber, password: $password)';
  }
}
