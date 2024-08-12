import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Create an instance of FlutterSecureStorage
  final _storage = const FlutterSecureStorage();

  // Write a value to secure storage
  Future<bool> writeValue(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      return true;
    } catch (e) {
      // Handle any exceptions here
      log("Error writing value:"+ e.toString());
      return false;
    }
  }

  // Read a value from secure storage
  Future<String?> readValue(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      // Handle any exceptions here
      throw Exception("Error reading value: $e");
    }
  }

  // Delete a value from secure storage
  Future<bool> deleteValue(String key) async {
    try {
      await _storage.delete(key: key);
      return true;
    } catch (e) {
      // Handle any exceptions here
      log("Error deleting value: $e");
      return false;
    }
  }

  // Check if a key exists in secure storage
  Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (e) {
      // Handle any exceptions here
      throw Exception("Error checking key existence: $e");
    }
  }

  // Delete all keys and values from secure storage
  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      // Handle any exceptions here
      throw Exception("Error deleting all values: $e");
    }
  }
}
