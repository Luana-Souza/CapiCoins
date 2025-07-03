import 'package:capi_coins/view/tela_home.dart';
import 'package:capi_coins/view/tela_login.dart';
import 'package:capi_coins/view/lista_disciplina.dart';
import 'package:capi_coins/view/tela_disciplina.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:capi_coins/core/routes/app_routes.dart';

import 'core/disciplinas/models/disciplina.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CapiCoins',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        AppRoutes.home: (context) => RoteadorTela(),
        AppRoutes.listaAtividades: (context) => ListaDisciplina(),
        AppRoutes.cadastro: (context) => TelaLogin(),
        AppRoutes.telaHome: (context) => TelaHome(),
        AppRoutes.telaDisciplina: (context) {
          final disciplina = ModalRoute.of(context)!.settings.arguments as Disciplina;
          return TelaDisciplina(disciplina: disciplina);
        },
      },
    );
  }
}

class RoteadorTela extends StatelessWidget {
  const RoteadorTela({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TelaHome();
        } else {
          return TelaLogin();
        }
      },
    );
  }
}
