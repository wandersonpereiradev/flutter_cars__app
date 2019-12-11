
import 'dart:async';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/usuario.dart';

class LoginBloc {

  final _streamController = StreamController<bool>();

  get stream => _streamController.stream;
  Future<ApiResponse<Usuario>> login(String login, String senha) async {

    // passando o valor "true" para o StreamBuilder
    _streamController.add(true);

    ApiResponse response = await LoginApi.login(login, senha);

    // passando o valor "false" para o StreamBuilder
    _streamController.add(false);

    return response;
  }

  void dispose() {
    _streamController.close();
  }
}