import 'package:capi_coins/core/routes/app_routes.dart';
import 'package:capi_coins/view/tela_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../core/disciplinas/models/atividade.dart';
import '../core/disciplinas/models/avaliacao.dart';
import '../core/disciplinas/models/disciplina.dart';
import '../core/usuarios/models/aluno.dart';
import '../core/usuarios/models/professor.dart';
import '../core/usuarios/models/tipo_usuario.dart';
import '../core/usuarios/models/usuario.dart';
import '../core/usuarios/service/aluno_service.dart';
import '../core/usuarios/service/auth_service.dart';
import '../core/usuarios/service/professor_service.dart';


class TelaHome extends StatelessWidget {
  Future<Usuario?> obterUsuarioAtual() async {
    final user = AuthService().currentUser;
    if (user == null) return null;

    final doc = await FirebaseFirestore.instance.collection('usuarios').doc(user.uid).get();
    final data = doc.data();
    if (data == null) return null;

    final tipo = data['tipo'];
    if (tipo == 'aluno') {
      return Aluno.fromMap(doc.id, data);
    } else if (tipo == 'professor') {
      return Professor.fromMap(doc.id, data);
    }
    return null;
  }

  Future<void> logoutUsuario(Usuario? usuario) async {
    if (usuario == null) return;
    final tipo = usuario.getTipo();
    if (tipo == TipoUsuario.professor) {
      await ProfessorService().sair();
    } else if (tipo == TipoUsuario.aluno) {
      await AlunoService().sair();
    }
  }
  final List<Disciplina> listaDisciplinas = [Disciplina(
    id: '001',
    professorId: '002',
    alunosIds: [],
    nome: 'Linguagem de programação 1',
    turma: 01,
    instituicao: 'UFMS-CPCX',
    atividades: [],
    avaliacoes: [],)
  , Disciplina(
    id: '002',
    professorId: '003',
    alunosIds: [],
    nome: 'Banco de dados 1',
    turma: 01,
    instituicao: 'UFMS-CPCX',
    atividades: [],
    avaliacoes: [],
    ),
  ];
  final List<String> alunosIds = [
    '001',
    '002',
    '003',
    '004',
  ];

  final List<Atividade> listaAtividades = [
    //faça pelo menos duas atividades
    Atividade(
      id: '00',
      nome: 'Atividade 01',
      descricao: 'Entregar o trabalho de matemática',
      prazoDeEntrega: Timestamp.fromDate(DateTime.now().add(Duration(days: 7))),
      prazoEntregada: null,
      creditoMinimo: 10,
      creditoMaximo: 20,
      credito: 15,
    ),
    Atividade(
      id: '01',
      nome: 'Atividade 02',
      descricao: 'Entregar o trabalho de português',
      prazoDeEntrega: Timestamp.fromDate(DateTime.now().add(Duration(days: 7))),
      prazoEntregada: null,
      creditoMinimo: 10,
      creditoMaximo: 20,
      credito: 15,
    )

  ];
  final List<Avaliacao> listAvaliacoes = [
    Avaliacao(
      id: '001',
      nome: 'Prova 01',
      sigla: 'P01',
      data: Timestamp.fromDate(DateTime.now().add(Duration(days: 7))),
      pontuacao: null,
    ),
    Avaliacao(
      id: '002',
      nome: 'Prova 02',
      sigla: 'P02',
      data: Timestamp.fromDate(DateTime.now().add(Duration(days: 7))),
      pontuacao: null,
    )

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Minhas disciplinas",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white
          ),
        ),
        backgroundColor: Color(0xFF0A6D92),
        centerTitle: true,
        toolbarHeight: 65,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(children: [

          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF0A6D92),
            ),
            child: Text(
              "Olá, ${AuthService().currentUser?.displayName ?? 'Usuário'}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Sair"),
            onTap: () async {
              print("Sair do usuário");
              await logoutUsuario(await obterUsuarioAtual());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => TelaLogin()),
              );
            },),
        ],)
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

      },
        child: Icon(Icons.add),),
      body: ListView(
        children:  List.generate(listaDisciplinas.length, (index){
          Disciplina disciplina = listaDisciplinas[index];
          return ListTile(
            title: Text("${disciplina.nome} - ${disciplina.instituicao}"),
            subtitle: Text("Turma - ${disciplina.turma.toString()}"),
              onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.telaDisciplina,
              arguments: disciplina,
            );
          },
          );
        },),
      )
      ,
    );
  }
}
