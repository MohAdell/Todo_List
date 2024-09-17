import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesClass {
  static const String keyname = "username";

  Future setName(String name) async {
    SharedPreferences SP = await SharedPreferences.getInstance();
    await SP.setString(keyname, name);
  }

  Future<String?> getName() async {
    SharedPreferences SP = await SharedPreferences.getInstance();
    return SP.getString(keyname);
  }

  Future clearName() async {
    SharedPreferences SP = await SharedPreferences.getInstance();
    await SP.remove(keyname);
  }
}
