 import 'package:capi_coins/core/usuarios/models/tipo_usuario.dart';
import 'package:capi_coins/core/usuarios/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../excecoes/camada_de_erros.dart';
import '../models/aluno.dart';
import '../models/professor.dart';

class UsuarioDAO {
  late CollectionReference<Map<String, dynamic>> usuarioCollection;

  UsuarioDAO() {
    usuarioCollection = FirebaseFirestore.instance.collection('usuarios');
  }

  Future<void> salvarUsuario(Usuario usuario) async {
    try {
      final usuarios = usuario.toMap()
        ..['tipo'] = usuario.getTipo().name;
      if (usuario.id.isEmpty) {
        await usuarioCollection.add(usuarios);
      } else {
        await usuarioCollection.doc(usuario.id).set(usuarios);
      }
    } catch (e) {
      throw CamadaDeErros('Erro ao salvar o usuário', code: 'SALVAR_USUARIO_ERRO');
    }
  }

  Future<List<Usuario>> listarUsuarios() async {
    try {
      final snapshot = await usuarioCollection.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final tipo = _getTipoUsuario(data);
        data['id'] = doc.id;
        return _criarUsuarioAPartirDoTipo(tipo, data); // Adicionado "return"
      }).toList();
    } catch (e) {
      throw CamadaDeErros('Erro ao listar usuários', code: 'LISTAR_USUARIOS_ERRO');
    }
  }

  Future<List<Professor>> buscarTodosProfessores() async {
    final snapshot = await usuarioCollection.where('tipo', isEqualTo: TipoUsuario.professor.name).get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return Professor.fromMap(data);
    }).toList();
  }

  Future<List<Aluno>> buscarTodosAlunos() async {
    final snapshot = await usuarioCollection.where('tipo', isEqualTo: TipoUsuario.aluno.name).get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return Aluno.fromMap(data);
    }).toList();
  }

  Future<List<Usuario>> buscarComPaginacao({DocumentSnapshot? startAfterDoc, int limit = 10, String? tipoUsuario}) async {
    try {
      Query query = construirQueryPaginada(startAfterDoc: startAfterDoc, limit: limit);

      if (tipoUsuario != null) {
        query = query.where('tipo', isEqualTo: tipoUsuario);
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final tipo = _getTipoUsuario(data);
        data['id'] = doc.id;
        return _criarUsuarioAPartirDoTipo(tipo, data);
      }).toList();
    } catch (e) {
      throw CamadaDeErros('Erro ao buscar usuários com paginação', code: 'BUSCAR_PAGINACAO_ERRO');
    }
  }

  Future<Usuario> buscarPorId(String id) async {
    try {
      final doc = await usuarioCollection.doc(id).get();
      if (!doc.exists) {
        throw CamadaDeErros('Usuário com ID $id não encontrado', code: 'USUARIO_NAO_ENCONTRADO');
      }
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      final tipo = _getTipoUsuario(data);
      return _criarUsuarioAPartirDoTipo(tipo, data);
    } catch (e) {
      throw CamadaDeErros('Erro ao buscar usuário por ID', code: 'BUSCAR_POR_ID_ERRO');
    }
  }

  Future<List<Usuario>> procurarUsuarioPorNome({required String nome, String? sobrenome,
  }) async {
    Query query = usuarioCollection.where('nome', isEqualTo: nome);

    if (sobrenome != null && sobrenome.isNotEmpty) {
      query = query.where('sobrenome', isEqualTo: sobrenome);
    }

    final snapshot = await query.get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final tipo = _getTipoUsuario(data);
      data['id'] = doc.id;
      return _criarUsuarioAPartirDoTipo(tipo, data);
    }).toList();
  }

  Future<void> atualizarUsuario(String id, Map<String, dynamic> novosDados) async {
    try {
      final doc = await usuarioCollection.doc(id).get();
      if (!doc.exists) {
        throw CamadaDeErros('Usuário com ID $id não encontrado', code: 'USUARIO_NAO_ENCONTRADO');
      }
      await usuarioCollection.doc(id).update(novosDados);
    } catch (e) {
      throw CamadaDeErros('Erro ao atualizar usuário com ID $id', code: 'ATUALIZAR_USUARIO_ERRO');
    }
  }

  //Deletar usuário
  // Se for necessário remover alguém.
  Future<void> deletarUsuario(String id) async {
    try {
      await usuarioCollection.doc(id).delete();
    } catch (e) {
      throw CamadaDeErros(
        'Erro ao deletar usuário com ID $id',
        code: 'DELETAR_USUARIO_ERRO',
      );
    }
  }

  Query construirQueryPaginada({DocumentSnapshot? startAfterDoc, int limit = 10}) {
    Query query = usuarioCollection.limit(limit);
    if (startAfterDoc != null) {
      query = query.startAfterDocument(startAfterDoc);
    }
    return query;
  }

  TipoUsuario _getTipoUsuario(Map<String, dynamic> data) {
    return TipoUsuario.values.firstWhere(
          (e) => e.name == data['tipo'],
      orElse: () => TipoUsuario.aluno,
    );
  }
  Usuario _criarUsuarioAPartirDoTipo(TipoUsuario tipo, Map<String, dynamic> data) {
    switch (tipo) {
      case TipoUsuario.professor:
        return Professor.fromMap(data);
      case TipoUsuario.aluno:
        return Aluno.fromMap(data);
    }
  }
}