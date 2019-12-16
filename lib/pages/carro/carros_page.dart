


import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_bloc.dart';
import 'package:carros/pages/carro/carros_listView.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

class CarrosPage extends StatefulWidget {
  String tipo;

  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

//AutomaticKeepAliveClientMixin -> mantém a lista de carros em memória
class _CarrosPageState extends State<CarrosPage> with AutomaticKeepAliveClientMixin<CarrosPage> {
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
    return StreamBuilder(
      // conectando ao _streamController para fazer um observable
      stream: _bloc.stream,
      builder: (context, snapshot) {
        //mostrando erro de carregamento da lista de carros
        if (snapshot.hasError) {
          return TextError("Não foi possível carregar o conteúdo");
        }

        //barra de carregamento
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosListView(carros),
        );
      },
    );
  }

  Future<void> _onRefresh() {
    return _bloc.fetch(tipo);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
