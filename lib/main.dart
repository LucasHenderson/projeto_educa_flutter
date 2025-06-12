import 'package:flutter/material.dart';
import 'package:projeto_educa_lucashenderson/screens/analise_curricular.dart';
import 'package:projeto_educa_lucashenderson/screens/boletim.dart';
import 'package:projeto_educa_lucashenderson/screens/grade_curricular.dart';
import 'package:projeto_educa_lucashenderson/screens/login.dart';
import 'package:projeto_educa_lucashenderson/screens/rematricula.dart';
import 'screens/situacao_academica.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal Acadêmico',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const SecretariaPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SecretariaPage extends StatelessWidget {
  const SecretariaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secretaria'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Secretaria',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _buildCard(
                    context,
                    title: 'BOLETIM (SEMESTRE ATUAL)',
                    description: 'Desempenho nas disciplinas do semestre atual',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Boletim(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    context,
                    title: 'GRADE CURRICULAR',
                    description:
                        'Selecione um curso e veja as disciplinas distribuídas por período.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GradeCurricularPage(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    context,
                    title: 'REMATRÍCULA ONLINE',
                    description:
                        'Fazer a rematrícula nos semestres posteriores, conforme calendário acadêmico. Emissão da declaração de vínculo.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RematriculaPage(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    context,
                    title: 'SITUAÇÃO ACADÊMICA',
                    description:
                        'Veja a sua situação junto à secretaria e demais departamentos da unitins.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SituacaoAcademicaPage(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    context,
                    title: 'ANÁLISE CURRICULAR',
                    description:
                        'Análise curricular completa.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AnaliseCurricularPage(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    context,
                    title: 'LOGIN',
                    description:
                        'Fazer login.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title,
      required String description,
      required VoidCallback onTap}) {
    return SizedBox(
      width: 300,
      height: 150,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 13),
                  overflow: TextOverflow.fade,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: onTap,
                  child: const Text('Acessar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
