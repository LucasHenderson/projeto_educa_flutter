import 'package:flutter/material.dart';

class GradeCurricularPage extends StatelessWidget {
  const GradeCurricularPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grade Curricular'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _gradeCurricular.entries.map((entry) {
            final String periodo = entry.key;
            final List<Disciplina> disciplinas = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  periodo,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: disciplinas.map((disciplina) {
                    return SizedBox(
                      width: 220,
                      height: 180,
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  disciplina.nome.trim(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'CH ${disciplina.ch}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Código: ${disciplina.codigo.trim()}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  static const Map<String, List<Disciplina>> _gradeCurricular = {
    "1º Período": [
      Disciplina("ALGORITMOS E PROGRAMAÇÃO I", "60", "011001131"),
      Disciplina("ARQUITETURA E ORGANIZAÇÃO DE COMPUTADORES I", "60", "011001132"),
      Disciplina("DESENVOLVIMENTO FRONT-END", "60", "011001133"),
      Disciplina("INGLÊS INSTRUMENTAL", "60", "011001134"),
      Disciplina("LEITURA E PRÁTICA DE PRODUÇÃO TEXTUAL", "60", "011001135"),
    ],
    "2º Período": [
      Disciplina("PRÉ-CÁLCULO", "60", "011001136"),
      Disciplina("GESTÃO DE PROCESSOS EMPRESARIAIS", "30", "011001137"),
      Disciplina("LÓGICA MATEMÁTICA", "30", "011001138"),
      Disciplina("ARQUITETURA E ORGANIZAÇÃO DE COMPUTADORES II", "60", "011001139"),
      Disciplina("BANCO DE DADOS I", "60", "011001140"),
      Disciplina("ALGORITMOS E PROGRAMAÇÃO II", "60", "011001141"),
    ],
    "3º Período": [
      Disciplina("CÁLCULO DIFERENCIAL E INTEGRAL", "60", "011001142"),
      Disciplina("METODOLOGIA CIENTÍFICA E DA PESQUISA", "30", "011001143"),
      Disciplina("SOCIEDADE E TECNOLOGIA", "30", "011001144"),
      Disciplina("ESTRUTURAS DE DADOS", "60", "011001145"),
      Disciplina("TÓPICOS EM PROGRAMAÇÃO I", "60", "011001146"),
      Disciplina("BANCO DE DADOS II", "60", "011001147"),
      Disciplina("EMPREENDEDORISMO E INOVAÇÃO", "60", "011001148"),
    ],
    "4º Período": [
      Disciplina("PROJETO INTEGRADOR I", "60", "011001149"),
      Disciplina("FUNDAMENTOS DE SISTEMAS DE INFORMAÇÃO", "30", "011001150"),
      Disciplina("ENGENHARIA DE REQUISITOS", "30", "011001151"),
      Disciplina("ENGENHARIA DE SOFTWARE I", "60", "011001152"),
      Disciplina("TÓPICOS EM PROGRAMAÇÃO II", "60", "011001153"),
      Disciplina("SISTEMAS OPERACIONAIS", "60", "011001154"),
      Disciplina("ASPECTOS TEÓRICOS DE COMPUTAÇÃO", "60", "011001155"),
    ],
    "5º Período": [
      Disciplina("PROJETO INTEGRADOR II", "60", "011001156"),
      Disciplina("GESTÃO ESTRATÉGICA DA INFORMAÇÃO", "30", "011001157"),
      Disciplina("OTIMIZAÇÃO PARA SISTEMAS", "30", "011001158"),
      Disciplina("ENGENHARIA DE SOFTWARE II", "60", "011001159"),
      Disciplina("COMPUTAÇÃO ORIENTADA A SERVIÇOS", "60", "011001160"),
      Disciplina("REDES DE COMPUTADORES I", "60", "011001161"),
      Disciplina("TÓPICOS EM PROGRAMAÇÃO III", "60", "011001162"),
    ],
    "6º Período": [
      Disciplina("ESTÁGIO SUPERVISIONADO", "60", "011001163"),
      Disciplina("INTERFACE HUMANO-COMPUTADOR", "60", "011001164"),
      Disciplina("GOVERNANÇA DE TI", "30", "011001165"),
      Disciplina("ENGENHARIA DE QUALIDADE", "30", "011001166"),
      Disciplina("ESTATÍSTICA COMPUTACIONAL", "60", "011001167"),
      Disciplina("INTELIGÊNCIA ARTIFICIAL", "60", "011001168"),
      Disciplina("REDES DE COMPUTADORES II", "60", "011001169"),
      Disciplina("PROGRAMAÇÃO PARA DISPOSITIVOS MÓVEIS I", "60", "011001170"),
    ],
    "7º Período": [
      Disciplina("ELABORAÇÃO E GESTÃO DE PROJETOS", "60", "011001171"),
      Disciplina("SISTEMAS DISTRIBUÍDOS", "60", "011001172"),
      Disciplina("MINERAÇÃO DE DADOS", "60", "011001173"),
      Disciplina("PROGRAMAÇÃO PARA DISPOSITIVOS MÓVEIS II", "60", "011001174"),
      Disciplina("TRABALHO DE CONCLUSÃO DE CURSO I", "60", "011001175"),
    ],
    "8º Período": [
      Disciplina("SEGURANÇA E AUDITORIA DE SISTEMAS", "60", "011001176"),
      Disciplina("DIREITO E LEGISLAÇÃO EM INFORMÁTICA", "60", "011001177"),
      Disciplina("SIMULAÇÃO DE SISTEMAS DE INFORMAÇÃO", "60", "011001178"),
      Disciplina("INFRAESTRUTURA DE REDES COMO SERVIÇOS", "60", "011001179"),
      Disciplina("TRABALHO DE CONCLUSÃO DE CURSO II", "60", "011001180"),
    ],
    "Disciplinas Optativas": [
      Disciplina("TÓPICOS ESPECIAIS EM METODOLOGIA DE PROJETO DE PESQUISA", "60", "011001181"),
      Disciplina("TÓPICOS ESPECIAIS EM ACESSIBILIDADE E USABILIDADE", "60", "011001182"),
      Disciplina("LIBRAS", "60", "011001183"),
      Disciplina("TÓPICOS ESPECIAIS EM SISTEMAS DE RECOMENDAÇÃO", "60", "011001184"),
      Disciplina("TÓPICOS ESPECIAIS EM SISTEMAS DE INFORMAÇÃO", "60", "011001185"),
      Disciplina("TÓPICOS ESPECIAIS EM COMPUTAÇÃO", "60", "011001186"),
      Disciplina("TÓPICOS ESPECIAIS EM ENGENHARIA DE SOFTWARE", "60", "011001187"),
      Disciplina("TÓPICOS ESPECIAIS EM PROGRAMAÇÃO", "60", "011001188"),
      Disciplina("TÓPICOS ESPECIAIS EM REDES DE COMPUTADORES", "60", "011001189"),
      Disciplina("TÓPICOS ESPECIAIS EM COMPUTAÇÃO GRÁFICA", "60", "011001190"),
      Disciplina("TÓPICOS ESPECIAIS EM BANCO DE DADOS", "60", "011001191"),
      Disciplina("TÓPICOS ESPECIAIS EM AMBIENTES WEB", "60", "011001192"),
      Disciplina("TÓPICOS ESPECIAIS EM INTELIGÊNCIA ARTIFICIAL", "60", "011001193"),
      Disciplina("PSICOLOGIA APLICADA A SISTEMAS DE INFORMAÇÃO", "60", "011001195"),
      Disciplina("INGLÊS PARA FINS ACADÊMICOS", "60", "011001196"),
      Disciplina("POLÍTICAS DE EDUCAÇÃO EM DIREITOS HUMANOS", "60", "011001197"),
    ],
  };
}

class Disciplina {
  final String nome;
  final String ch;
  final String codigo;

  const Disciplina(this.nome, this.ch, this.codigo);
}
