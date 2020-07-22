import 'package:cadastro_produtos/data/mock_data.dart';
import 'package:flutter/material.dart';

class ListaProduto extends StatefulWidget {
  static String routeName = '/lista';
  @override
  _ListaProdutoState createState() => _ListaProdutoState();
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
        itemBuilder: (context, index) => Column(
          children: <Widget>[
            Text(MockData.produtos.elementAt(index).nome),
            Text(MockData.produtos.elementAt(index).descricao),
          ],
        ),
        itemCount: MockData.produtos.length,
      ),
    );
  }
}
