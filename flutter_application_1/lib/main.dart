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
  List<Escolaridade> escolaridades = [];
  List<Projetos> projetos = [];
  List<Recomendacao> recomendacoes = [];

  Curriculo({required this.nome, required this.perfil});
}



class TelaCadastro extends StatefulWidget {
  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  Curriculo meuCurriculo = Curriculo(nome: "", perfil: "");

  TextEditingController nomeController = TextEditingController();
  TextEditingController perfilController = TextEditingController();
  TextEditingController escolaridadeController = TextEditingController();
  TextEditingController projetoController = TextEditingController();
  TextEditingController recomendacaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meu Currículo")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            
            CampoTexto("Nome", nomeController),
            CampoTexto("Perfil", perfilController),

            SizedBox(height: 20),

            
            Text("Escolaridade"),
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

            ...meuCurriculo.escolaridades.map((e) => Text("- ${e.nivel}")),

            SizedBox(height: 20),

            Text("Projetos"),
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

            ...meuCurriculo.projetos.map((p) => Text("- ${p.nome}")),

            SizedBox(height: 20),

            Text("Recomendações"),
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

            ...meuCurriculo.recomendacoes.map((r) => Text("- ${r.texto}")),

            SizedBox(height: 30),

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
            CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 40),
            ),

            SizedBox(height: 20),

            Text("Nome: ${curriculo.nome}"),
            Text("Perfil: ${curriculo.perfil}"),

            SizedBox(height: 20),

            Text("Escolaridade"),
            ...curriculo.escolaridades.map((e) => Text("- ${e.nivel}")),

            SizedBox(height: 20),

            Text("Projetos"),
            ...curriculo.projetos.map((p) => Text("- ${p.nome}")),

            SizedBox(height: 20),

            Text("Recomendações"),
            ...curriculo.recomendacoes.map((r) => Text("- ${r.texto}")),
          ],
        ),
      ),
    );
  }
}


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