import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_educa_lucashenderson/provider/auth_provider.dart';
import 'package:provider/provider.dart';

// Modelo de dados
class SituacaoAcademica {
  final String curso;
  final String situacao;
  final List<String> documentos;

  SituacaoAcademica({
    required this.curso,
    required this.situacao,
    required this.documentos,
  });

  factory SituacaoAcademica.fromJson(Map<String, dynamic> json) {
    return SituacaoAcademica(
      curso: json['curso'],
      situacao: json['situacao'],
      documentos: List<String>.from(json['documentos']),
    );
  }
}

class SituacaoAcademicaPage extends StatefulWidget {
  const SituacaoAcademicaPage({super.key});

  @override
  State<SituacaoAcademicaPage> createState() => _SituacaoAcademicaPageState();
}

class _SituacaoAcademicaPageState extends State<SituacaoAcademicaPage> {
  late Future<SituacaoAcademica> _futureSituacao;

  @override
  void initState() {
    super.initState();
    _futureSituacao = _fetchSituacaoAcademica();
  }

  Future<SituacaoAcademica> _fetchSituacaoAcademica() async {
    final response = await http.get(Uri.parse('https://684b8138ed2578be881b8de9.mockapi.io/situacao'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return SituacaoAcademica.fromJson(data[0]);
    } else {
      throw Exception('Falha ao carregar situação acadêmica');
    }
  }

  @override
  Widget build(BuildContext context) {
    final nome = Provider.of<AuthProvider>(context).nome ?? 'Usuário não encontrado';
    final matricula = Provider.of<AuthProvider>(context).matricula ?? 'Matrícula não encontrada';
    return Scaffold(
      appBar: AppBar(title: const Text('Situação Acadêmica')),
      body: FutureBuilder<SituacaoAcademica>(
        future: _futureSituacao,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Nenhum dado encontrado.'));
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Situação Acadêmica',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildField(label: 'Nº de Matrícula:', value: matricula),
                _buildField(label: 'Nome:', value: nome),
                _buildField(label: 'Curso:', value: data.curso),
                _buildField(label: 'Situação:', value: data.situacao),
                const SizedBox(height: 16),
                const Text(
                  'Documentos:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                ...data.documentos.map(_buildDocument).toList(),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.bottomRight,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Voltar'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildField({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: TextField(
              enabled: false,
              controller: TextEditingController(text: value),
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                isDense: true,
                disabledBorder: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocument(String docName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              enabled: false,
              controller: TextEditingController(text: docName),
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                isDense: true,
                disabledBorder: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
