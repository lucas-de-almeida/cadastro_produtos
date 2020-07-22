import 'dart:io';

import 'package:cadastro_produtos/data/mock_data.dart';
import 'package:cadastro_produtos/produto.dart';
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
  File _arquivo;

  Future<void> _tiraFoto(ImageSource source) async {
    var _pickFile = await _imagem.getImage(
      source: source,
    );
    if (_pickFile != null) {
      setState(() {
        _arquivo = File(_pickFile.path);
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
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          //colocar o campo de imagem e botao de tirar e selecionar foto Image.file(File(path)) ,FileImage(File(path))
          Column(
            children: <Widget>[
              _arquivo == null
                  ? Text('Nenhuma foto encontrada')
                  : FadeInImage(
                      placeholder: AssetImage('assets/loading.gif'),
                      image: FileImage(_arquivo),
                    ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton.icon(
                      onPressed: () => _tiraFoto(
                        ImageSource.camera,
                      ),
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
