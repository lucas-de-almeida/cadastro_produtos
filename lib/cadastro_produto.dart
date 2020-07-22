import 'package:cadastro_produtos/data/mock_data.dart';
import 'package:cadastro_produtos/produto.dart';
import 'package:flutter/material.dart';

class CasdastroProduto extends StatefulWidget {
  static String routeName = '/cadastro';
  @override
  _CasdastroProdutoState createState() => _CasdastroProdutoState();
}

class _CasdastroProdutoState extends State<CasdastroProduto> {
  TextEditingController _nome = TextEditingController();
  TextEditingController _descricao = TextEditingController();
  Produto produto = Produto();

  @override
  void dispose() {
    _nome.dispose();
    _descricao.dispose();
    super.dispose();
  }

  void save() {
    produto.nome = _nome.text;
    produto.descricao = _descricao.text;
    MockData.produtos.add(produto);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de produtos'),
      ),
      body: ListView(
        children: <Widget>[
          Form(
              child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'nome'),
                controller: _nome,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'descricao'),
                controller: _descricao,
              ),
              Row(
                children: <Widget>[
                  RaisedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.cancel),
                    label: Text('cancelar'),
                  ),
                  RaisedButton.icon(
                    onPressed: () {
                      save();
                    },
                    icon: Icon(Icons.save),
                    label: Text('cadastrar'),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
