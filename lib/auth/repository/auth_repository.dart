abstract class AuthRepository {
  Future<void> signUp(
      {required String email,
      required String password,
      required String name,
      required int phoneNumber});
  Future<void> signIn({
    required String email,
    required String password,
  });
  Future<void> signInWithGoogle();
  Future<void> signOut();
}
