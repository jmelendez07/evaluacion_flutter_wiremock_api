import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_taller/services/login_service.dart';

class CarService {
  static const String _url = 'https://carros-electricos.wiremockapi.cloud/carros';

  static Future<List<dynamic>?> fetchCars() async {
    try {
      String? token = await LoginService.getToken();

      if (token == null || token.isEmpty) {
        return [];
      }

      final response = await http.get(
        Uri.parse(_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> cars = jsonDecode(response.body);
        return cars;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}