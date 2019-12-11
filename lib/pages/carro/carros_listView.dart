import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/pages/carro/carros_bloc.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

import 'carros_api.dart';

class CarrosListView extends StatefulWidget {
  String tipo;

  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

//AutomaticKeepAliveClientMixin -> mantém a lista de carros em memória
class _CarrosListViewState extends State<CarrosListView>with AutomaticKeepAliveClientMixin<CarrosListView> {

  List<Carro> carros;

  // Criando uma varável para substituir a sintaxe "widget.tipo"
  String get tipo => widget.tipo;

  final _bloc = CarrosBloc();

  // método "wantKeepAlive" do AutomaticKeepAliveClientMixin | precisa ser true
  @override
  bool get wantKeepAlive => true;

  // Utilizando o initState() para fazer as requisições, assim o builder fica encarregado apenas de desenhar a tela
  @override
  void initState() {
    super.initState();
    _bloc.fetch(tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {

    // StreamBuilder funciona como um observable
    return StreamBuilder(
      // conectando ao _streamController para fazer um observable
      stream: _bloc.stream,
      builder: (context, snapshot) {
        //mostrando erro de carregamento da lista de carros
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Não foi possível carregar o conteúdo",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            ),
          );
        }

        //barra de carregamento
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;
        return _listView(carros);
      },
    );
  }

  Container _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (context, index) {
          Carro c = carros[index];
          return Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      // Se a foto não existir, irá utilizar a imagem da url passa depois dos "??"
                      c.urlFoto ??
                          "https://images-na.ssl-images-amazon.com/images/I/51oWFC9vf8L._SX425_.jpg",
                      width: 250,
                    ),
                  ),
                  Text(
                    c.nome,
                    //para exibir apenas uma linha
                    maxLines: 1,
                    //indica que o texto não coube na tela
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(fontSize: 22),
                  ),
                  Text(
                    "descrição...",
                    style: TextStyle(fontSize: 16),
                  ),
                  ButtonTheme.bar(
                    // make buttons use the appropriate styles for cards
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETALHES'),
                          onPressed: () => _onClickCarro(c),
                        ),
                        FlatButton(
                          child: const Text('SHARE'),
                          onPressed: () {
                            /* ... */
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro(Carro c) {
    push(context, CarroPage(c));
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
