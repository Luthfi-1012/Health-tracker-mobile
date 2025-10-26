// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const String TOKEN = "token";
// ignore: constant_identifier_names
const String USER_ID = "userID";
// ignore: constant_identifier_names
const String USERNAME = "username";

class UserInfo {
  // Simpan token
  Future<void> setToken(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(TOKEN, value);
  }

  // Ambil token
  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(TOKEN);
  }

  // Simpan user ID
  Future<void> setUserID(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(USER_ID, value);
  }

  // Ambil user ID
  Future<String?> getUserID() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(USER_ID);
  }

  // Simpan username
  Future<void> setUsername(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(USERNAME, value);
  }

  // Ambil username
  Future<String?> getUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(USERNAME);
  }

  // Hapus semua data (logout)
  Future<void> logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
