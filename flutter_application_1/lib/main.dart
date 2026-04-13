import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TelaCadastro(),
    debugShowCheckedModeBanner: false,
  ));
}


class Escolaridade {
  String nivel;
  Escolaridade(this.nivel);
}

class Projetos {
  String nome;
  Projetos(this.nome);
}

class Recomendacao {
  String texto;
  Recomendacao(this.texto);
}

class Curriculo {
  String nome;
  String perfil;
  String imagemPath;

  List<Escolaridade> escolaridades = [];
  List<Projetos> projetos = [];
  List<Recomendacao> recomendacoes = [];

  Curriculo({
    required this.nome,
    required this.perfil,
    required this.imagemPath,
  });
}


class TelaCadastro extends StatefulWidget {
  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  Curriculo meuCurriculo = Curriculo(
    nome: "",
    perfil: "",
    imagemPath: 'images/eu.jpg',
  );

  TextEditingController nomeController = TextEditingController();
  TextEditingController perfilController = TextEditingController();
  TextEditingController escolaridadeController = TextEditingController();
  TextEditingController projetoController = TextEditingController();
  TextEditingController recomendacaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar Currículo")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            AvatarWidget(imagemPath: meuCurriculo.imagemPath),

            CampoTexto("Nome", nomeController),
            CampoTexto("Perfil", perfilController),

            SecaoTitulo("Escolaridade"),
            CampoTexto("Adicionar escolaridade", escolaridadeController),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  meuCurriculo.escolaridades.add(
                    Escolaridade(escolaridadeController.text),
                  );
                  escolaridadeController.clear();
                });
              },
              child: Text("Adicionar"),
            ),

            ...meuCurriculo.escolaridades.asMap().entries.map((entry) {
              int index = entry.key;
              var e = entry.value;

              return ItemListaDismissible(
                texto: e.nivel,
                chave: Key(e.nivel + index.toString()),
                onDelete: () {
                  setState(() {
                    meuCurriculo.escolaridades.removeAt(index);
                  });
                },
              );
            }),

            SecaoTitulo("Projetos"),
            CampoTexto("Adicionar projeto", projetoController),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  meuCurriculo.projetos.add(
                    Projetos(projetoController.text),
                  );
                  projetoController.clear();
                });
              },
              child: Text("Adicionar"),
            ),

            ...meuCurriculo.projetos.asMap().entries.map((entry) {
              int index = entry.key;
              var p = entry.value;

              return ItemListaDismissible(
                texto: p.nome,
                chave: Key(p.nome + index.toString()),
                onDelete: () {
                  setState(() {
                    meuCurriculo.projetos.removeAt(index);
                  });
                },
              );
            }),

            SecaoTitulo("Recomendações"),
            CampoTexto("Adicionar recomendação", recomendacaoController),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  meuCurriculo.recomendacoes.add(
                    Recomendacao(recomendacaoController.text),
                  );
                  recomendacaoController.clear();
                });
              },
              child: Text("Adicionar"),
            ),

            ...meuCurriculo.recomendacoes.asMap().entries.map((entry) {
              int index = entry.key;
              var r = entry.value;

              return ItemListaDismissible(
                texto: r.texto,
                chave: Key(r.texto + index.toString()),
                onDelete: () {
                  setState(() {
                    meuCurriculo.recomendacoes.removeAt(index);
                  });
                },
              );
            }),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                meuCurriculo.nome = nomeController.text;
                meuCurriculo.perfil = perfilController.text;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TelaExibicao(curriculo: meuCurriculo),
                  ),
                );
              },
              child: Text("Salvar e Ver Currículo"),
            ),
          ],
        ),
      ),
    );
  }
}


class TelaExibicao extends StatelessWidget {
  final Curriculo curriculo;

  TelaExibicao({required this.curriculo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meu Currículo")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            AvatarWidget(imagemPath: curriculo.imagemPath),

            SizedBox(height: 20),

            Text("Nome: ${curriculo.nome}"),
            Text("Perfil: ${curriculo.perfil}"),

            SecaoTitulo("Escolaridade"),
            ...curriculo.escolaridades.map((e) => ItemLista(e.nivel)),

            SecaoTitulo("Projetos"),
            ...curriculo.projetos.map((p) => ItemLista(p.nome)),

            SecaoTitulo("Recomendações"),
            ...curriculo.recomendacoes.map((r) => ItemLista(r.texto)),
          ],
        ),
      ),
    );
  }
}


// Avatar melhorado
class AvatarWidget extends StatelessWidget {
  final String imagemPath;

  AvatarWidget({required this.imagemPath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(imagemPath),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}

// Título
class SecaoTitulo extends StatelessWidget {
  final String texto;

  SecaoTitulo(this.texto);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        texto,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ItemLista extends StatelessWidget {
  final String texto;

  ItemLista(this.texto);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 4),
      child: Text("- $texto"),
    );
  }
}

class ItemListaDismissible extends StatelessWidget {
  final String texto;
  final VoidCallback onDelete;
  final Key chave;

  ItemListaDismissible({
    required this.texto,
    required this.onDelete,
    required this.chave,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: chave,
      direction: DismissDirection.endToStart,

      confirmDismiss: (direction) async {
        onDelete(); 
        return true;
      },

      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),

      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 4),
        child: Text("- $texto"),
      ),
    );
  }
}

// Campo texto
class CampoTexto extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  CampoTexto(this.label, this.controller);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }
}