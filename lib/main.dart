import 'package:cadastro_produtos/produto/cadastro_produto.dart';
import 'package:cadastro_produtos/home/home_page.dart';
import 'package:cadastro_produtos/produto/lista_produto.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home page',
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) {
          return HomePage();
        },
        CasdastroProduto.routeName: (context) {
          return CasdastroProduto();
        },
        ListaProduto.routeName: (context) {
          return ListaProduto();
        },
      },
    );
  }
}
