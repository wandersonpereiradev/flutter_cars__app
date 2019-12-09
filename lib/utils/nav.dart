
import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page, {bool replace = false,}) {

  //caso o "replace" seja true, o uso do pushReplacement vai quebrar a navegação entre telas
  //Ele destrói o empilhamento de telas a tela chamada substitui a anterior que deixa de existir
  if(replace){
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
      return page;
    }));
  }

  return Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
    return page;
  }));
}
