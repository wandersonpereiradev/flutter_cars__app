import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_listView.dart';
import 'package:carros/pages/carro/carros_page.dart';
import 'package:carros/utils/prefs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// SingleTickerProviderStateMixin -> evita que fique buscando a lista de carros no servidor e a mantém em memória
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  // _tabController para criar índice e deixar a última aba selecionada ativa qdo houve novo login
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // criando um callback future para pegar o último índice
    Future<int> future = Prefs.getInt("tabIdx");
    future.then((int idx) {
      _tabController.index = idx;
    });

    _tabController.index = 1;

    //colocando Listener nas abas
    _tabController.addListener((){
      print("Tab ${_tabController.index}");
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Clássicos"),
            Tab(text: "Esportivos"),
            Tab(text: "Luxo"),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        CarrosPage(TipoCarro.classicos),
        CarrosPage(TipoCarro.esportivos),
        CarrosPage(TipoCarro.luxo),
      ]),
      drawer: DrawerList(),
    );
  }
}
