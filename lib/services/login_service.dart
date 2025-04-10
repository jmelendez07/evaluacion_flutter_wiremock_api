import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginService {
  static const _secureStorage = FlutterSecureStorage();

  static Future<void> save(String token) async {
    if(token.isNotEmpty) {
      await _secureStorage.write(key: "token", value: token);
    }
  }

  static Future<String?> getToken() async {
    return await _secureStorage.read(key: "token");
  }

  static Future<bool> fetch(data) async {
    // LA API NO SE ENCUENTRA DISPONIBLE, POR LO QUE COMENTE ESTE CODIGO.
    // final response = await http.post(
    //   Uri.parse('https://carros-electricos.wiremockapi.cloud/auth'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(data),
    // );

    // if (response.statusCode == 200) {
    //   final token = jsonDecode(response.body)['token'];
    //   await save(token);
    //   return true;
    // } else {
    //   return false;
    // }

    if (data["username"] == "admin") {
      await save("token");
      return true;
    } else {
      return false;
    }
  }
}