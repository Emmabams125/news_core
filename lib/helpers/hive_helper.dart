import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static const String tokenBox = 'tokenBox';
  static const String tokenKey = 'accessToken';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(tokenBox);
  }

  static Future<void> saveToken(String token) async {
    final box = Hive.box(tokenBox);
    await box.put(tokenKey, token);
  }

  static String? getToken() {
    final box = Hive.box(tokenBox);
    return box.get(tokenKey);
  }

  static Future<void> clearToken() async {
    final box = Hive.box(tokenBox);
    await box.delete(tokenKey);
  }
}
