import 'package:capi_coins/core/usuarios/models/tipo_usuario.dart';
import 'package:capi_coins/core/usuarios/models/usuario.dart';
import 'package:flutter/cupertino.dart';

class Aluno extends Usuario {
  final String rga;

  Aluno({
    required super.nome,
    required super.sobrenome,
    required super.email,
    required super.senha,
    required super.criado_em,
    required this.rga,
    required id
  }) : super(id: id);

  @override
  TipoUsuario getTipo() {
    return TipoUsuario.aluno;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'usuarioNome': nome,
      'usuarioSobrenome': sobrenome,
      'usuarioEmail': email,
      'usuarioSenha': senha,
      'rga': rga,
      'tipo': getTipo().name,
      'criado_em': criado_em,
    };
  }

  factory Aluno.fromMap(Map<String, dynamic> map) {
    return Aluno(
      id: map['id'] ?? '',
      nome: map['usuarioNome'] ?? '',
      sobrenome: map['usuarioSobrenome'] ?? '',
      email: map['usuarioEmail'] ?? '',
      senha: map['usuarioSenha'] ?? '',
      rga: map['rga'] ?? '',
      criado_em: map['criado_em'] ?? '',
    );
  }
}
