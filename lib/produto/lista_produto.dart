import 'dart:io';

import 'package:cadastro_produtos/produto/cadastro_produto.dart';
import 'package:cadastro_produtos/data/mock_data.dart';
import 'package:flutter/material.dart';

class ListaProduto extends StatefulWidget {
  static String routeName = '/lista';
  @override
  _ListaProdutoState createState() => _ListaProdutoState();
}

class Argumentos {
  int index;
  Argumentos({this.index});
}

class _ListaProdutoState extends State<ListaProduto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de produtos'),
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        //carregar o widget pelo file image = file que carrega um path
        itemBuilder: (context, index) => GestureDetector(
          child: Image.file(
            File(MockData.produtos.elementAt(index).foto),
            fit: BoxFit.cover,
          ),
          onTap: () async {
            await Navigator.of(context).pushNamed(CasdastroProduto.routeName,
                arguments: Argumentos(index: index));
            setState(() {
              MockData.produtos;
            });
          },
          onLongPress: () {
            return showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: Text(
                    '${MockData.produtos.elementAt(index).nome}',
                  ),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        top: 20,
                      ),
                      child: Text(
                        '${MockData.produtos.elementAt(index).descricao}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
        itemCount: MockData.produtos.length,
      ),
    );
  }
}
