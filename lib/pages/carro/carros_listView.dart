
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_page.dart' show CarroPage;
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CarrosListView extends StatelessWidget {

  List<Carro> carros;

  CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
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
                          onPressed: () => _onClickCarro(context, c),
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

  _onClickCarro(context, Carro c) {
    push(context, CarroPage(c));
  }
}
