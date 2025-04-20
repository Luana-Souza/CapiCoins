import 'package:capi_coins/core/usuarios/models/tipo_usuario.dart';
import 'package:capi_coins/core/usuarios/models/usuario.dart';

class Professor extends Usuario{
  final String siape;
  Professor({
    required super.nome,
    required super.sobrenome,
    required super.email,
    required super.senha,
    required super.criado_em,
    required this.siape,
    required id
  }): super(id: id);

  @override
  TipoUsuario getTipo() {
    return TipoUsuario.professor;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'usuarioNome': nome,
      'usuarioSobrenome': sobrenome,
      'usuarioEmail': email,
      'usuarioSenha': senha,
      'siape': siape,
      'tipo': getTipo().name,
      'criado_em': criado_em,
    };
  }

  factory Professor.fromMap(Map<String, dynamic> map){
    return Professor(
      id: map['id'] ?? '',
      nome: map['usuarioNome'] ?? '',
      sobrenome: map['usuarioSobrenome'] ?? '',
      email: map['usuarioEmail'] ?? '',
      senha: map['usuarioSenha'] ?? '',
      siape: map['siape'] ?? '',
      criado_em: map['criado_em'] ?? '',
    );
  }

}