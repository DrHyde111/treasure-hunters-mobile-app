import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> login(String email, String password) async {
  try {
    var response = await http.post(
      Uri.parse('http://192.168.0.107:8080/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception(responseBody['message']);
    }
  } catch (error) {
    print(error);
    throw Exception("Error during sending login request!");
  }
}
