import 'dart:io';

import 'package:cadastro_produtos/data/mock_data.dart';
import 'package:cadastro_produtos/produto/lista_produto.dart';
import 'package:cadastro_produtos/produto/produto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CasdastroProduto extends StatefulWidget {
  static String routeName = '/cadastro';
  @override
  _CasdastroProdutoState createState() => _CasdastroProdutoState();
}

class _CasdastroProdutoState extends State<CasdastroProduto> {
  TextEditingController _nome = TextEditingController();
  TextEditingController _descricao = TextEditingController();
  Produto produto = Produto();
  final _imagem = ImagePicker();
  final _form = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();
  File _arquivo;

  Future<void> _tiraFoto(ImageSource source) async {
    print(' foto');

    var _pickFile = await _imagem.getImage(
      source: source,
    );
    if (_pickFile != null) {
      setState(() {
        produto.foto = _pickFile.path;
        // _arquivo = File(_pickFile.path);
      });
    }
  }

  @override
  void dispose() {
    _nome.dispose();
    _descricao.dispose();
    super.dispose();
  }

  void save() {
    print('save ');
    produto.nome = _nome.text;
    produto.descricao = _descricao.text;
    MockData.produtos.add(produto);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final Argumentos argumento = ModalRoute.of(context).settings.arguments;

    Future<void> _atualizaFoto(ImageSource source) async {
      print('atualiza foto');
      var _pickFile = await _imagem.getImage(
        source: source,
      );
      if (_pickFile != null) {
        setState(() {
          MockData.produtos[argumento.index].foto = _pickFile.path;
          // _arquivo = File(_pickFile.path);
        });
      }
    }

    if (argumento != null) {
      _nome.text = MockData.produtos[argumento.index].nome;
      _descricao.text = MockData.produtos[argumento.index].descricao;
      produto.foto = MockData.produtos[argumento.index].foto;
    }
    void saveEdicao() {
      print('save edição');
      setState(() {
        MockData.produtos[argumento.index].nome = _nome.text;
        MockData.produtos[argumento.index].descricao = _descricao.text;
        MockData.produtos[argumento.index].foto = produto.foto;
      });
      Navigator.of(context).pop();
    }

    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text('Cadastro de produtos'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          //colocar o campo de imagem e botao de tirar e selecionar foto Image.file(File(path)) ,FileImage(File(path))
          Column(
            children: <Widget>[
              produto.foto == null
                  ? Text('Nenhuma foto encontrada')
                  : FadeInImage(
                      fit: BoxFit.fitHeight,
                      placeholder: AssetImage('assets/loading.gif'),
                      image: FileImage(
                        File(produto.foto),
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton.icon(
                      onPressed: () {
                        if (argumento != null) {
                          _atualizaFoto(
                            ImageSource.camera,
                          );
                        } else {
                          _tiraFoto(
                            ImageSource.camera,
                          );
                        }
                      },
                      icon: Icon(Icons.camera_alt),
                      label: Text('Tirar foto'),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: RaisedButton.icon(
                      onPressed: () => _tiraFoto(
                        ImageSource.gallery,
                      ),
                      icon: Icon(
                        Icons.photo_library,
                      ),
                      label: Text('Selecionar foto'),
                    ),
                  ),
                ],
              )
            ],
          ),
          Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    labelText: 'nome',
                  ),
                  controller: _nome,
                  validator: (nome) {
                    print('validator');
                    if ((nome.length ?? 0) <= 3) return 'Nome muito curto';
                    if ((nome.length ?? 0) >= 30) return 'Nome muito longo';
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    labelText: 'descricao',
                  ),
                  controller: _descricao,
                  validator: (descricao) {
                    print('validator');
                    if ((descricao.length ?? 0) <= 5)
                      return 'descrição muito curto';
                    if ((descricao.length ?? 0) >= 30)
                      return 'descrição muito longo';
                    return null;
                  },
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
                        if (produto.foto == null) {
                          _scaffold.currentState.showSnackBar(
                            SnackBar(
                              content: Text('Por favor adicione uma foto'),
                            ),
                          );
                        } else {
                          if (_form.currentState.validate()) {
                            if (argumento != null) {
                              saveEdicao();
                            } else {
                              save();
                            }
                          }
                        }
                      },
                      icon: Icon(Icons.save),
                      label: Text('cadastrar'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
