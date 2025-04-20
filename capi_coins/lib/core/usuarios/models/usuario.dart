import 'package:capi_coins/core/usuarios/models/tipo_usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Usuario {
  final String id;
  final String nome;
  final String sobrenome;
  final String email;
  final String senha;
  final Timestamp criado_em;

  const Usuario({
    String? id,
    required this.nome,
    required this.sobrenome,
    required this.email,
    required this.senha,
    required this.criado_em
  }) : id = id ?? '';

  TipoUsuario getTipo();

  Map<String, dynamic> toMap();

}
//frommap: construtor nomeado tomap?
