import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  // Initialize the cache
  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Get a string value from the cache using a key
  String? getDataString({required String key}) {
    return sharedPreferences.getString(key);
  }

  // Save data to the cache using a key
  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else {
      return await sharedPreferences.setStringList(key, value);
    }
  }

  // Get any type of data from the cache using a key
  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  // Remove data from the cache using a key
  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  // Check if the cache contains a specific key
  Future<bool> containsKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }

  // Clear all data from the cache
  Future<bool> clearData() async {
    return sharedPreferences.clear();
  }

  // Save data to the cache using a key (alternative method)
  Future<dynamic> put({required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else {
      return await sharedPreferences.setInt(key, value);
    }
  }
}
