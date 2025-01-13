import 'dart:async';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late SharedPreferences _prefs;

  SharedPreferences get prefs => _prefs;

  final iosOptions = const IOSOptions(
    accessibility: KeychainAccessibility.first_unlock_this_device,
  );

  Future<Storage> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<String?> read(String key, {bool private = false}) async {
    try {
      if (private) {
        return await _storage.read(key: key, iOptions: iosOptions);
      } else {
        return _prefs.getString(key);
      }
    } catch (e, stack) {
      log('$e, $stack', name: 'Storage Read Error');
      return null;
    }
  }

  Future<void> write(String key, String value, {bool private = false}) async {
    try {
      if (private) {
        await _storage.write(key: key, value: value, iOptions: iosOptions);
      } else {
        await _prefs.setString(key, value);
      }
    } catch (e, stack) {
      log('$e, $stack', name: 'Storage Write Error');
    }
  }

  Future<void> delete(String key) async {
    try {
      await _prefs.remove(key);
      await _storage.delete(key: key, iOptions: iosOptions);
    } catch (e, stack) {
      log('$e, $stack', name: 'Storage Delete Error');
    }
  }
}
