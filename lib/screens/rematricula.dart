import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_educa_lucashenderson/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class RematriculaPage extends StatefulWidget {
  const RematriculaPage({super.key});

  @override
  State<RematriculaPage> createState() => _RematriculaPageState();
}

class _RematriculaPageState extends State<RematriculaPage> {
  final String alunoNome = 'Lucas Cunha';
  final String periodoAtual = '6º Período';

  bool isLoading = true;
  String? error;
  List<Disciplina> disciplinas = [];

  @override
  void initState() {
    super.initState();
    fetchDisciplinasDoPeriodo();
  }

  Future<void> fetchDisciplinasDoPeriodo() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simula requisição

      disciplinas = [
        Disciplina(dia: 'Segunda', nome: 'Estatística Computacional', selecionada: true),
        Disciplina(dia: 'Terça', nome: 'Engenharia de Qualidade', selecionada: true),
        Disciplina(dia: 'Quarta', nome: 'Redes de Computadores II', selecionada: true),
        Disciplina(dia: 'Quinta', nome: 'Governança de TI', selecionada: true),
        Disciplina(dia: 'Sexta', nome: 'Inteligência Artificial', selecionada: true),
        Disciplina(dia: 'Sábado', nome: 'Programação para Dispositivos Móveis I', selecionada: true),
      ];

      setState(() => isLoading = false);
    } catch (e) {
      setState(() {
        isLoading = false;
        error = 'Erro ao carregar disciplinas: $e';
      });
    }
  }

  Future<void> enviarRematricula() async {
    final selecionadas = disciplinas
        .where((d) => d.selecionada)
        .map((d) => d.nome)
        .toList();

    final body = {
      'periodo': periodoAtual,
      'disciplinasSelecionadas': selecionadas,
    };

    const url = 'https://sua-api.com/rematricula'; // atualize aqui

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rematrícula salva com sucesso!')),
        );
      } else {
        throw Exception('Erro ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar rematrícula: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final nome = Provider.of<AuthProvider>(context).nome ?? 'Usuário';
    final matricula = Provider.of<AuthProvider>(context).matricula ?? 'Matrícula não encontrada';
    return Scaffold(
      appBar: AppBar(title: const Text('Rematrícula')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            '👤 Aluno: $nome\n📚 Matrícula: $matricula\n📅 Período Atual: $periodoAtual',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Selecione as disciplinas:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          itemCount: disciplinas.length,
                          itemBuilder: (context, index) {
                            final d = disciplinas[index];
                            return Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          d.nome,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 4),
                                        Text('Dia: ${d.dia}',
                                            style: const TextStyle(
                                                color: Colors.grey)),
                                      ],
                                    ),
                                    Switch(
                                      value: d.selecionada,
                                      activeColor: Colors.indigo,
                                      onChanged: (value) {
                                        setState(() {
                                          d.selecionada = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: enviarRematricula,
        icon: const Icon(Icons.save),
        label: const Text('Salvar'),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}

class Disciplina {
  final String nome;
  final String dia;
  bool selecionada;

  Disciplina({
    required this.nome,
    required this.dia,
    this.selecionada = true, // ativado por padrão
  });
}
