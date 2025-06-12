import 'package:capi_coins/core/excecoes/camada_de_erros.dart';
import 'package:capi_coins/core/usuarios/models/tipo_usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Usuario {
  final String id;
  String _nome;
  String _sobrenome;
  String _email;
  final Timestamp criado_em;

  Usuario({
    String? id,
    required String nome,
    required String sobrenome,
    required String email,
    required this.criado_em,
  })  : id = id ?? '',
        _nome = _validarNome(nome),
        _sobrenome = _validarSobrenome(sobrenome),
        _email = _validarEmail(email);

  TipoUsuario getTipo();

  Map<String, dynamic> toMap();

  String get nome => _nome;
  String get sobrenome => _sobrenome;
  String get email => _email;

  set nome(String nome) => _nome = _validarNome(nome);
  set sobrenome(String sobrenome) => _sobrenome = _validarSobrenome(sobrenome);
  set email(String email) => _email = _validarEmail(email);
  //validações

  static String _validarNome (String nome){
    nome = nome.trim();

    if(nome.length < 2 || nome.length > 60) {
      throw CamadaDeErros('O nome deve ter entre 2 e 60 caracteres');
    } else if (!RegExp(r"^[A-Za-zÀ-ÿ\s]+$").hasMatch(nome)) {
      throw CamadaDeErros('Nome com caracter inválido');
    }
    return nome;
  }

  //validar sobrenome
  static String _validarSobrenome (String sobrenome){
    sobrenome = sobrenome.trim();

    if(sobrenome.length < 2 || sobrenome.length > 60) {
      throw CamadaDeErros('O sobrenome deve ter entre 2 e 60 caracteres');
    } else if (!RegExp(r"^[A-Za-zÀ-ÿ\s]+$").hasMatch(sobrenome)) {
      throw CamadaDeErros('Sobrenomeome com caracter inválido');
    }
    return sobrenome;
  }

  static String _validarEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$');
    email = email.trim();

    if (!regex.hasMatch(email)) {
      throw CamadaDeErros('Email inválido');
    }
    return email;
  }

  // fazer um toString
  @override
  String toString(){
    return 'Usuario{nome: $nome, sobrenome: $sobrenome  email: $email}';
  }
  // validações para formulário
  static String? validarEmailForm(String? email) {
    if (email == null || email.trim().isEmpty) return 'Informe um e-mail';
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$').hasMatch(email.trim())) {
      return 'E-mail inválido';
    }
    return null; // válido
  }

  static String? validarSenha(String? senha) {
    if (senha == null || senha.trim().isEmpty) {
      return 'Informe uma senha';
    }
    if (senha.length<8) {
      return 'Senha inválida';
    }
    return null;
  }
  static String? validarNomeForm(String? nome){
    if(nome == null || nome.trim().isEmpty) {
      return 'Informe um nome';
    }
    nome = nome.trim();
    if(nome.length < 2 || nome.length > 60) {
      return 'O nome deve ter entre 2 e 60 caracteres';
    } else if (!RegExp(r"^[A-Za-zÀ-ÿ\s]+$").hasMatch(nome)) {
      return 'Nome com caracter inválido';
    }
    return null;
  }
  static String? validarSobrenomeForm(String? sobrenome) {
    if (sobrenome == null || sobrenome.trim().isEmpty) {
      return 'Informe um sobrenome';
    }
    sobrenome = sobrenome?.trim();
    if(sobrenome!.length < 2 || sobrenome.length > 60) {
      return 'O sobrenome deve ter entre 2 e 60 caracteres';
    } else if (!RegExp(r"^[A-Za-zÀ-ÿ\s]+$").hasMatch(sobrenome)) {
      return 'Sobrenomeome com caracter inválido';
    }
    return null;
  }

}

