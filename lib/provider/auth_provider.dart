import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _nome;
  String? _matricula;

  String? get nome => _nome;
  String? get matricula => _matricula;
  
  void setMatricula(String novaMatricula) {
    _matricula = novaMatricula;
    notifyListeners(); // Atualiza os widgets que escutam esse provider
  }
  
  void setNome(String novoNome) {
    _nome = novoNome;
    notifyListeners(); // Atualiza os widgets que escutam esse provider
  }

  void logout() {
    _nome = null;
    notifyListeners();
  }
}
