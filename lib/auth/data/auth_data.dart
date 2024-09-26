import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:na_hive_bloc/constants/key_value_contants.dart';

class UserAuthData {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> storeUserData({required String token}) async {
    await storage.write(
      key: KeyValue.userToken,
      value: token,
    );
  }

  Future<void> deleteUserData() async {
    await storage.delete(
      key: KeyValue.userToken,
    );
  }

  Future<bool> checkUserData() async {
    Map<String, String> list = await storage.readAll();
    if (list.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<String?> getUserData() async {
    try {
      return await storage.read(key: KeyValue.userToken);
    } catch (e) {
      return null;
    }
  }
}
