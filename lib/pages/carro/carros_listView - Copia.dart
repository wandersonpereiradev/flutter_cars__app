import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_page.dart';
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

  // método "wantKeepAlive" do AutomaticKeepAliveClientMixin | precisa ser true
  @override
  bool get wantKeepAlive => true;

  // A busca na API ficou no initState() para evitar que, após carregada, a informação não seja requisitada a cada reload,
  // tirando isso do build (que agora pode desenhar a tela mais rapidamente).
  @override
  void initState() {
    super.initState();
    _loadingData();
  }

  _loadingData() async {
    List<Carro> carros = await CarrosApi.getCarros(widget.tipo);
    setState(() {
      this.carros = carros;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    //barra de carregamento
    if (carros == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return _listView(carros);

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
}
