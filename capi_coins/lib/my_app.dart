import 'package:capi_coins/view/tela_home.dart';
import 'package:capi_coins/view/tela_loguin.dart';
import 'package:capi_coins/view/lista_disciplina.dart';
import 'package:capi_coins/view/tela_disciplina.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget{
  static const HOME = '/';
  static const TELADISCIPLINA = 'tela-disciplina';
  static const LISTAATIVIDADES = 'lista-atividades';
  static const CADASTRO ='autenticacao';
  static const TELAHOME = 'tela-home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CapiCoins',
      theme: ThemeData(
        primarySwatch: Colors.blue,
    ),
    routes:{
    HOME: (context)=> Autenticacao(),
      TELADISCIPLINA: (context) => TelaDisciplina(),
      LISTAATIVIDADES: (context) => ListaDisciplina(),
      CADASTRO: (context) => Autenticacao(),
      TELAHOME: (context) => TelaHome(),

  },
    );
    }
}