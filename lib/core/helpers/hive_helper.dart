
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static const String tokenBox = "tokenBox";

  static Future<void> setToken(String token) async {
    await Hive.box(tokenBox).put(tokenBox, token);
  }

  static bool getToken() {
    return Hive.box(tokenBox).isNotEmpty;
  }

}
