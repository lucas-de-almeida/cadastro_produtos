import 'package:cadastro_produtos/cadastro_produto.dart';
import 'package:cadastro_produtos/lista_produto.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home Page'),
              onTap: () {
                Navigator.of(context).pushNamed(HomePage.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('List Page'),
              onTap: () {
                Navigator.of(context).pushNamed(ListaProduto.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Cadastro produto'),
              onTap: () {
                Navigator.of(context).pushNamed(CasdastroProduto.routeName);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text(
          'Seja bem vindo',
          style: TextStyle(fontSize: 26),
        ),
      ),
    );
  }
}
