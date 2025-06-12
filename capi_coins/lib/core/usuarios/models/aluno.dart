import 'package:capi_coins/core/excecoes/camada_de_erros.dart';
import 'package:capi_coins/core/usuarios/models/tipo_usuario.dart';
import 'package:capi_coins/core/usuarios/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Aluno extends Usuario {
   String rga;

   Aluno({
     required super.nome,
     required super.sobrenome,
     required super.email,
     required super.criado_em,
     required String rga,
     required id
   })  : rga = validarRga(rga), super(id: id);


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
      'rga': rga,
      'tipo': getTipo().name,
      'criado_em': criado_em,
    };
  }

  factory Aluno.fromMap(String id, Map<String, dynamic> map) {
    return Aluno(
      id: id,
      nome: map['usuarioNome'] ?? '',
      sobrenome: map['usuarioSobrenome'] ?? '',
      email: map['usuarioEmail'] ?? '',
      rga: map['rga'] ?? '',
      criado_em: map['criado_em'] ?? Timestamp.now(),
    );
  }


  //validar rga, deve conter 12 caracteres
  static String validarRga(String rga){
    rga = rga.trim();
    if(rga.length != 12){
      throw CamadaDeErros('RGA deve conter 12 caracteres');
    }
    return rga;
  }


  //toString
  @override
  String toString(){
    return'Aluno{nome: $nome,sobrenome: $sobrenome rga: $rga, email: $email}';
  }

}
