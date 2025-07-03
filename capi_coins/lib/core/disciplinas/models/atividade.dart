import 'package:cloud_firestore/cloud_firestore.dart';

class Atividade{
  String id;
  String nome;
  String descricao;
  Timestamp? prazoEntregada;
  Timestamp prazoDeEntrega;
  int? credito;
  int creditoMinimo;
  int creditoMaximo;

  Atividade({
    required this.id,
    required this.nome,
    required this.descricao,
    this.prazoEntregada,
    required this.prazoDeEntrega,
    this.credito,
    required this.creditoMinimo,
    required this.creditoMaximo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'prazoEntregada': prazoEntregada,
      'prazoDeEntrega': prazoDeEntrega,
      'credito': credito,
      'creditoMinimo': creditoMinimo,
      'creditoMaximo': creditoMaximo,
    };
  }

  factory Atividade.fromMap(Map<String, dynamic> map) {
    return Atividade(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
      prazoEntregada: map['prazoEntregada'] as Timestamp?,
      prazoDeEntrega: map['prazoDeEntrega'] as Timestamp,
      credito: map['credito'],
      creditoMinimo: map['creditoMinimo'] ?? 0,
      creditoMaximo: map['creditoMaximo'] ?? 0,
    );
  }
  @override
  String toString() {
    return 'Atividade{nome: $nome, descricao: $descricao, prazoEntregada: $prazoEntregada,prazoDeEntrega: $prazoDeEntrega creditoMinimo: $creditoMinimo, creditoMaximo: $creditoMaximo}';
  }
}