
import 'package:connectivity/connectivity.dart';

Future<bool> isNetworkOn() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  //Se não houver conexão, seja por Wifi ou 4G, retorna false
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}