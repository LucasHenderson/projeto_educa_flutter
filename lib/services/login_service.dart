import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<bool> login(String email, String password) async {
    final url = Uri.parse(
      'https://684abfe6165d05c5d35a25da.mockapi.io/usuario?email=$email&senha=$password',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List && data.isNotEmpty) {
        return true; // Login válido
      } else {
        return false; // Usuário não encontrado
      }
    } else {
      throw Exception('Erro de conexão com a API');
    }
  }
}
