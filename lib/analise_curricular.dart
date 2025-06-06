import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnaliseCurricularPage extends StatefulWidget {
  const AnaliseCurricularPage({super.key});

  @override
  State<AnaliseCurricularPage> createState() => _AnaliseCurricularPageState();
}

class _AnaliseCurricularPageState extends State<AnaliseCurricularPage> {
  List<Disciplina> disciplinas = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchDisciplinas();
  }

  Future<void> fetchDisciplinas() async {
    const url = 'https://sua-api.com/analise-curricular'; // atualize aqui

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          disciplinas = data.map((e) => Disciplina.fromJson(e)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Erro ${response.statusCode} ao carregar dados.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Erro ao conectar: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = disciplinas.length;
    final cursadas = disciplinas.where((d) => d.status == 'cursada').length;
    final progresso = total > 0 ? cursadas / total : 0.0;

    return Scaffold(
      appBar: AppBar(title: const Text('Análise Curricular')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Progresso Acadêmico',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: progresso,
                        minHeight: 12,
                        backgroundColor: Colors.grey[300],
                        color: Colors.green,
                      ),
                      const SizedBox(height: 8),
                      Text('${(progresso * 100).toStringAsFixed(1)}% concluído'),
                      const SizedBox(height: 24),
                      const Text(
                        'Disciplinas:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: disciplinas.length,
                          itemBuilder: (context, index) {
                            final d = disciplinas[index];
                            final icon = _getIconForStatus(d.status);
                            final color = _getColorForStatus(d.status);
                            final label = _getLabelForStatus(d.status);

                            return Card(
                              elevation: 2,
                              child: ListTile(
                                leading: Icon(icon, color: color),
                                title: Text(d.nome),
                                subtitle: Text(label),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  IconData _getIconForStatus(String status) {
    switch (status) {
      case 'cursada':
        return Icons.check_circle;
      case 'cursando':
        return Icons.book;
      case 'pendente':
        return Icons.lock;
      default:
        return Icons.help;
    }
  }

  Color _getColorForStatus(String status) {
    switch (status) {
      case 'cursada':
        return Colors.green;
      case 'cursando':
        return Colors.blue;
      case 'pendente':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  String _getLabelForStatus(String status) {
    switch (status) {
      case 'cursada':
        return 'Cursada';
      case 'cursando':
        return 'Em andamento';
      case 'pendente':
        return 'Pendente';
      default:
        return 'Desconhecido';
    }
  }
}

class Disciplina {
  final String nome;
  final String status;

  Disciplina({required this.nome, required this.status});

  factory Disciplina.fromJson(Map<String, dynamic> json) {
    return Disciplina(
      nome: json['nome'],
      status: json['status'],
    );
  }
}
