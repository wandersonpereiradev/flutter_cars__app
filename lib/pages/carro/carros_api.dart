
import 'dart:convert' as convert;
import 'package:carros/pages/favoritos/carro_dao.dart';
import 'package:carros/pages/login/usuario.dart';

import 'carro.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {

    Usuario user = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}",
    };
    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';
    print("GET >>> $url");
    var response = await http.get(url, headers: headers);
    String json = response.body;
    try {
      List list = convert.json.decode(json);
      // Usando a função map() para percorrer a lista de carros
      List<Carro> carros = list.map((map) => Carro.fromMap(map)).toList();

      return carros;
    } catch(error, exception) {
      print("$error >>> $exception");
      throw error;
    }
  }
}