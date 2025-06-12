import 'package:flutter/material.dart';

class TelaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bem-vindo!")),
      body: Center(child: Text("Você entrou com sucesso!")),
    );
  }
}
