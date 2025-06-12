import 'package:capi_coins/core/excecoes/camada_de_erros.dart';
import 'package:capi_coins/core/usuarios/models/tipo_usuario.dart';
import 'package:capi_coins/core/usuarios/models/usuario.dart';

class Professor extends Usuario{
  String siape;

  Professor({
    required super.nome,
    required super.sobrenome,
    required super.email,
    required super.criado_em,
    required String siape,
    required id
  }): siape = validarSiape(siape), super(id: id);

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
      'siape': siape,
      'tipo': getTipo().name,
      'criado_em': criado_em,
    };
  }

  factory Professor.fromMap(String id, Map<String, dynamic> map) {
    return Professor(
      id: id,
      nome: map['usuarioNome'] ?? '',
      sobrenome: map['usuarioSobrenome'] ?? '',
      email: map['usuarioEmail'] ?? '',
      siape: map['siape'] ?? '',
      criado_em: map['criado_em'] ?? '',
    );
  }

  //validar codigosiape
  static String validarSiape(String siape){
    siape = siape.trim();
    if(siape.length != 7){
      throw CamadaDeErros('Siape deve conter 7 caracteres');
    }
    return siape;
  }

  //toString
  String toString(){
    return'Professor{nome: $nome,sobrenome: $sobrenome rga: $siape, email: $email}';
  }

}