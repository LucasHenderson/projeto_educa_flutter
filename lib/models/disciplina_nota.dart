class DisciplinaNota {
  final String periodoLetivo;
  final String codigo;
  final String disciplina;
  final int? faltas;
  final double? a1;
  final double? a2;
  final double? exameFinal;
  final double? mediaSemestral = 0.0;
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
    this.mediaFinal,
    required this.situacao,
  });

  factory DisciplinaNota.fromJson(Map<String, dynamic> json) {
    return DisciplinaNota(
      periodoLetivo: json['periodo'],
      codigo: json['codigo'],
      disciplina: json['disciplina'],
      faltas: json['faltas'],
      a1: (json['a1'] as num?)?.toDouble(),
      a2: (json['a2'] as num?)?.toDouble(),
      exameFinal: (json['exame_final'] as num?)?.toDouble(),
      mediaFinal: (json['media_final'] as num?)?.toDouble(),
      situacao: json['situacao'],
    );
  }
}