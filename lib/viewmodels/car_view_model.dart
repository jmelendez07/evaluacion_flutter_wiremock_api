import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_taller/models/car_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CarViewModel extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  final String _url = "https://67f7d1812466325443eadd17.mockapi.io/carros";

  List<CarModel> _cars = [];
  List<CarModel> get cars => _cars;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadCarsFromStorage() async {
    _isLoading = true;
    notifyListeners();

    final data = await _storage.read(key: "cars");
    if (data != null) {
      final decodedData = jsonDecode(data) as List<dynamic>;
      _cars = decodedData
          .map((item) => CarModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } else {
      _cars = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveCar(CarModel car) async {
    _cars.add(car);
    final carListAsJson = _cars.map((c) => c.toJson()).toList();
    await _storage.write(key: "cars", value: jsonEncode(carListAsJson));
    notifyListeners();
  }

  Future<CarModel?> getCarByIdFromApi(String id) async {
    final url = '$_url/$id';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CarModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error con la API: $e');
    }
  }
}