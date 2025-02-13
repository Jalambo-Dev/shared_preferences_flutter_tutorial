import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _sharedPreferences;

  /// Initialize the cache
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Get a string value from the cache using a key
  String? getDataString({required String key}) {
    return _sharedPreferences.getString(key);
  }

  /// Save data to the cache using a key
  Future<bool> saveData({required String key, required dynamic value}) async {
    switch (value.runtimeType) {
      case const (bool):
        return await _sharedPreferences.setBool(key, value);
      case const (String):
        return await _sharedPreferences.setString(key, value);
      case const (int):
        return await _sharedPreferences.setInt(key, value);
      case const (double):
        return await _sharedPreferences.setDouble(key, value);
      case const (List<String>):
        return await _sharedPreferences.setStringList(key, value);
      default:
        throw ArgumentError.value(
          value,
          'value',
          'Unsupported type',
        );
    }
  }

  /// Get any type of data from the cache using a key
  dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  /// Remove data from the cache using a key
  Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  /// Check if the cache contains a specific key
  static Future<bool> containsKey({required String key}) async {
    return _sharedPreferences.containsKey(key);
  }

  /// Clear all data from the cache
  Future<bool> clearData() async {
    return await _sharedPreferences.clear();
  }
}
