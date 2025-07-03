import 'package:cloud_firestore/cloud_firestore.dart';

class Avaliacao{
  String id;
  String nome;
  String sigla;
  Timestamp data;
  int? pontuacao;
  Avaliacao({
    required this.id,
    required this.nome,
    required this.sigla,
    required this.data,
    this.pontuacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'sigla': sigla,
      'data': data,
      'pontuacao': pontuacao,
    };
  }
  factory Avaliacao.fromMap(Map<String, dynamic> map) {
    return Avaliacao(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      sigla: map['sigla'] ?? '',
      data: map['data'] as Timestamp,
      pontuacao: map['pontuacao'],
    );
  }
  @override
  String toString() {
    return "Avaliacao{nome: $nome, sigla: $sigla, data: $data, pontuacao: $pontuacao}";
  }
}