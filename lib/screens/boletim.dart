import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Boletim extends StatefulWidget {
  const Boletim({super.key});

  @override
  State<Boletim> createState() => _BoletimState();
}

class _BoletimState extends State<Boletim> {
  List<DisciplinaNota> _disciplinas = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    fetchNotas();
  }

  Future<void> fetchNotas() async {
    const url = 'https://sua-api.com/disciplina-notas'; // substitua aqui
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _disciplinas = data.map((e) => DisciplinaNota.fromJson(e)).toList();
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Erro ao carregar dados. Código: ${response.statusCode}';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Erro: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Disciplinas do Semestre Letivo")),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : _error != null
                ? Text(_error!)
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(16),
                    child: DataTable(
                      columnSpacing: 20,
                      headingRowColor:
                          MaterialStateProperty.all(Colors.grey.shade200),
                      columns: const [
                        DataColumn(label: Text('Período Letivo')),
                        DataColumn(label: Text('Código')),
                        DataColumn(label: Text('Disciplina')),
                        DataColumn(label: Text('Faltas')),
                        DataColumn(label: Text('A1')),
                        DataColumn(label: Text('A2')),
                        DataColumn(label: Text('Exame Final')),
                        DataColumn(label: Text('Média Semestral')),
                        DataColumn(label: Text('Média Final')),
                        DataColumn(label: Text('Situação')),
                      ],
                      rows: _disciplinas.map((disciplina) {
                        return DataRow(cells: [
                          DataCell(Text(disciplina.periodoLetivo)),
                          DataCell(Text(disciplina.codigo)),
                          DataCell(Text(disciplina.disciplina)),
                          DataCell(Text('${disciplina.faltas ?? '-'}')),
                          DataCell(Text('${disciplina.a1 ?? '-'}')),
                          DataCell(Text('${disciplina.a2 ?? '-'}')),
                          DataCell(Text('${disciplina.exameFinal ?? '-'}')),
                          DataCell(Text('${disciplina.mediaSemestral ?? '-'}')),
                          DataCell(Text('${disciplina.mediaFinal ?? '-'}')),
                          DataCell(Text(disciplina.situacao)),
                        ]);
                      }).toList(),
                    ),
                  ),
      ),
    );
  }
}

class DisciplinaNota {
  final String periodoLetivo;
  final String codigo;
  final String disciplina;
  final int? faltas;
  final double? a1;
  final double? a2;
  final double? exameFinal;
  final double? mediaSemestral;
  final double? mediaFinal;
  final String situacao;

  DisciplinaNota({
    required this.periodoLetivo,
    required this.codigo,
    required this.disciplina,
    this.faltas,
    this.a1,
    this.a2,
    this.exameFinal,
    this.mediaSemestral,
    this.mediaFinal,
    required this.situacao,
  });

  factory DisciplinaNota.fromJson(Map<String, dynamic> json) {
    return DisciplinaNota(
      periodoLetivo: json['periodoLetivo'],
      codigo: json['codigo'],
      disciplina: json['disciplina'],
      faltas: json['faltas'],
      a1: (json['a1'] as num?)?.toDouble(),
      a2: (json['a2'] as num?)?.toDouble(),
      exameFinal: (json['exameFinal'] as num?)?.toDouble(),
      mediaSemestral: (json['mediaSemestral'] as num?)?.toDouble(),
      mediaFinal: (json['mediaFinal'] as num?)?.toDouble(),
      situacao: json['situacao'],
    );
  }
}
