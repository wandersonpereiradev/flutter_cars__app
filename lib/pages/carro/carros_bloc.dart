import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/favoritos/carro_dao.dart';
import 'package:carros/utils/network.dart';

class CarrosBloc {
  final _streamController = StreamController<List<Carro>>();

  Stream<List<Carro>> get stream => _streamController.stream;

  Future<List<Carro>> fetch(String tipo) async {
    try {
      //Atribuindo o retorno do método isNetworkOn() para a variável
      bool networkOn = await isNetworkOn();
      // Buscando a lista de carros no DB se não houver conexão com a internet
      if (!networkOn) {
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        _streamController.add(carros);
        return carros;
      }
      List<Carro> carros = await CarrosApi.getCarros(tipo);
      if (carros.isNotEmpty) {
        // Criando uma instância de CarroDao() e salvando no DB
        final dao = CarroDAO();
        // Salvar todos os carros
        carros.forEach(dao.save);
      }
      _streamController.add(carros);
      return carros;
    } catch (e) {
      print(e);
      _streamController.addError(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
