import 'package:carros/widgets/text.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

class CarroPage extends StatelessWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton<String>(
            // Pegando o item clicado
            onSelected: _onClickPopupMenu,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: "Editar",
                  child: Text("Editar"),
                ),
                PopupMenuItem(
                  value: "Deletar",
                  child: Text("Deletar"),
                ),
                PopupMenuItem(
                  value: "Share",
                  child: Text("Share"),
                ),
              ];
            },
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Image.network(carro.urlFoto),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // usando o "text" que está na pasta widgets
                  text(
                    carro.nome,
                    fontSize: 20,
                    bold: true,
                  ),
                  text(
                    carro.tipo,
                    fontSize: 16,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 40,
                    ),
                    onPressed: _onClickFavorito,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      size: 40,
                    ),
                    onPressed: _onClickShare,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  // Tratando os dados do menu Popup
  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        print("Editar.");
        break;
      case "Deletar":
        print("Deletar.");
        break;
      case "Share":
        print("Share.");
        break;
    }
  }

  void _onClickFavorito() {}

  void _onClickShare() {}
}
