import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginViewModel extends ChangeNotifier {
  final _secureStorage = const FlutterSecureStorage();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _token;
  String? get token => _token;

  String? _error;
  String? get error => _error;

  Future<bool> login(Map<String, dynamic> data) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    if (data["username"] == "admin") {
      _token = "token";
      await _secureStorage.write(key: "token", value: _token);
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _error = "Credenciales inválidas";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> loadToken() async {
    _token = await _secureStorage.read(key: "token");
    notifyListeners();
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: "token");
    _token = null;
    notifyListeners();
  }
}