import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'package:projeto_educa_lucashenderson/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginService {
  static Future<bool> login(String email, String password, BuildContext context,) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final url = Uri.parse(
      'https://684abfe6165d05c5d35a25da.mockapi.io/usuario?email=$email&senha=$password',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List && data.isNotEmpty) {
        authProvider.setNome(data[0]['name']);
        authProvider.setMatricula(data[0]['matricula']);
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Erro de conexão com a API');
    }
  }
}
