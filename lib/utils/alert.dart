import 'package:flutter/material.dart';

alert(context, String msg) {
  showDialog(
      context: context,
      //Para não fechar a caixa de diálogo qdo clicar fora dela
      barrierDismissible: false,
      builder: (context) {
        //AlertDialog foi envolvido pelo WillPopScope para usar o "onWillPop"
        return WillPopScope(
          //Para não permitir que a caixa de diálogo feche qdo clicar em voltar no Aparelho
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text("Carros"),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
}
