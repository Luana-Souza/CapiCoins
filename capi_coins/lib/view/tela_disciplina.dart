import 'package:flutter/material.dart';

class TelaDisciplina extends StatelessWidget {
  const TelaDisciplina({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: (Text('Disciplina 1')),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            print("FOI CLICADO");
          },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: (){},
              child: Text('Criar atividade')),
        ],
      )
    );
  }
}