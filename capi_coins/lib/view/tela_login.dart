import 'package:capi_coins/core/usuarios/models/tipo_usuario.dart';
import 'package:flutter/material.dart';
import 'package:capi_coins/core/usuarios/service/aluno_service.dart';
import 'package:capi_coins/core/usuarios/service/professor_service.dart';
import 'package:capi_coins/core/usuarios/models/aluno.dart';
import 'package:capi_coins/core/usuarios/models/professor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/usuarios/service/auth_service.dart';
import '../widget/AuthForm.dart';


class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}
final _formKey = GlobalKey<FormState>();
bool isLogin = true;
TipoUsuario? _tipoUsuarioRadio;

final _emailController = TextEditingController();
final _senhaController = TextEditingController();
final _confirmarSenhaController = TextEditingController();
final _nomeController = TextEditingController();
final _sobrenomeController = TextEditingController();
final _tipoUsuarioController = TextEditingController();



class _TelaLoginState extends State<TelaLogin> {
  bool entrar = true;
  TipoUsuario _tipoUsuarioRadio = TipoUsuario.aluno;
  String? _tipoUsuario;
  bool  isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  //    backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blueAccent,
                  Colors.cyanAccent
                ]
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
              child: Center(
              child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset("assets/logo.png"),
                   AuthForm(
                    formKey: _formKey,
                    isLogin: isLogin,
                    tipoUsuarioRadio: _tipoUsuarioRadio,
                    onTipoUsuarioChanged: (TipoUsuario? value) {
                      setState(() {
                        _tipoUsuarioRadio = value!;
                      });
                    },
                    emailController: _emailController,
                    senhaController: _senhaController,
                    confirmarSenhaController: _confirmarSenhaController,
                    nomeController: _nomeController,
                    sobrenomeController: _sobrenomeController,
                    tipoUsuarioController: _tipoUsuarioController,
                  ),
                  SizedBox(height: 16),

                  isLoading
                      ? LinearProgressIndicator()
                      : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: isLoading
                      ? null // desativa o botão enquanto carrega
                      : () async {
                      if (_formKey.currentState!.validate()) {
                      setState(() => isLoading = true); // Ativa o indicador

                      if (_formKey.currentState!.validate()) {
                        final email = _emailController.text.trim();
                        final senha = _senhaController.text.trim();

                        if (isLogin) {
                          try {
                            final authService = AuthService();
                            final firebaseUser = await authService.signIn(email: email, password: senha);

                            if (firebaseUser != null) {
                              final doc = await FirebaseFirestore.instance.collection("usuarios").doc(firebaseUser.uid).get();
                              final tipo = doc.data()?['tipo'];

                              if (tipo == "aluno") {
                                final alunoService = AlunoService();
                                final aluno = await alunoService.entrar(email, senha);

                                if (aluno != null) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/tela-home',
                                  );
                                  return;
                                }
                              } else if (tipo == "professor") {
                                final professorService = ProfessorService();
                                final professor = await professorService.entrar(email, senha);

                                if (professor != null) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/tela-home',
                                  );
                                  return;
                                }
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Usuário não encontrado no banco de dados.')),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Erro ao entrar: $e')),
                            );
                          }
                          setState(() { isLoading = false; });
                        } else {
                          final nome = _nomeController.text.trim();
                          final sobrenome = _sobrenomeController.text.trim();
                          final tipoUsuario = _tipoUsuarioController.text.trim();

                          try {
                            if (_tipoUsuarioRadio == TipoUsuario.aluno) {
                              final alunoService = AlunoService();
                              final aluno = Aluno(
                                id: '',
                                nome: nome,
                                sobrenome: sobrenome,
                                email: email,
                                rga: tipoUsuario,
                                criado_em: Timestamp.now(),
                              );
                              await alunoService.criarConta(aluno, senha);
                            } else {
                              final professorService = ProfessorService();
                              final professor = Professor(
                                id: '',
                                nome: nome,
                                sobrenome: sobrenome,
                                email: email,
                                siape: tipoUsuario,
                                criado_em: Timestamp.now(),
                              );
                              await professorService.criarConta(professor, senha);
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Conta criada com sucesso!')),
                            );

                            setState(() {
                              isLoading = true;
                              isLogin = true;
                            });

                            _emailController.clear();
                            _senhaController.clear();
                            _confirmarSenhaController.clear();
                            _nomeController.clear();
                            _sobrenomeController.clear();
                            _tipoUsuarioController.clear();
                            _tipoUsuarioRadio = TipoUsuario.aluno;
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Erro ao cadastrar: $e')),
                            );
                          }
                        }
                      }
                      setState(() => isLoading = false);
                      }
                      },
                    child: isLoading
                        ? SizedBox(
                      height: 14,
                      width: 14,
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                        : Text(isLogin ? "Entrar" : "Cadastrar"),
                  ),

                  TextButton(onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                    child: Text(isLogin ? "Não tem uma conta? Cadastre-se" : "Já tem uma conta? entre"),
                  ),
                ],
              )
              ),
            ),
            ),
        ],
    )
    );
  }

}
