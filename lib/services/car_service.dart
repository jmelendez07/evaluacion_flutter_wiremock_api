import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CarService {
  final _storage = const FlutterSecureStorage();
  final String _url = "https://67f7d1812466325443eadd17.mockapi.io/carros";

  Future<void> saveCar(Map<String, dynamic> car) async {
    final cars = await getCars();
    cars.add(car.map((key, value) => MapEntry(key, value.toString())));
    await _storage.write(key: "cars", value: jsonEncode(cars));
  }

  Future<List<Map<String, String>>> getCars() async {
    final data = await _storage.read(key: "cars");
    if (data != null) {
      final decodedData = jsonDecode(data) as List<dynamic>;
      return decodedData.map((item) {
        return Map<String, String>.from(item.map((key, value) => 
          MapEntry(key.toString(), value.toString())));
      }).toList();
    }
    return [];
  }

  Future<Map<String, dynamic>?> getCarById(String id) async {
    final url = '$_url/$id';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error con la API: $e');
    }
  }
}