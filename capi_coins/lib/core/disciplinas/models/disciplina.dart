import 'atividade.dart';
import 'avaliacao.dart';

class Disciplina {
  final String id;
  final String professorId;
  final List<String> alunosIds;
  final String nome;
  final int turma;
  final String instituicao;
  final List<Atividade> atividades;
  final List<Avaliacao> avaliacoes;

  Disciplina({
    String? id,
    required this.professorId,
    List<String>? alunosIds,
    required this.nome,
    required this.turma,
    required this.instituicao,
    List<Atividade>? atividades,
    List<Avaliacao>? avaliacoes,
  })  : id = id ?? '',
        alunosIds = alunosIds ?? [],
        atividades = atividades ?? [],
        avaliacoes = avaliacoes ?? [];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'professorId': professorId,
      'alunosIds': alunosIds,
      'nome': nome,
      'turma': turma,
      'instituicao': instituicao,
      'atividades': atividades.map((atividade) => atividade.toMap()).toList(),
      'avaliacoes': avaliacoes.map((avaliacao) => avaliacao.toMap()).toList(),
    };
  }

  factory Disciplina.fromMap(Map<String, dynamic> map) {
    return Disciplina(
      id: map['id'] ?? '',
      professorId: map['professorId'] ?? '',
      alunosIds: List<String>.from(map['alunosIds'] ?? []),
      nome: map['nome'] ?? '',
      turma: map['turma'] ?? 0,
      instituicao: map['instituicao'] ?? '',
      atividades: map['atividades'] != null
          ? List<Atividade>.from(
              (map['atividades'] as List).map((a) => Atividade.fromMap(a)))
          : [],
      avaliacoes: map['avaliacoes'] != null
          ? List<Avaliacao>.from(
              (map['avaliacoes'] as List).map((a) => Avaliacao.fromMap(a)))
          : [],
    );
  }
}