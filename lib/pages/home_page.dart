

import 'package:api_md_26/pages/consulta_cep_fragment.dart';
import 'package:api_md_26/pages/lista_cidades_fragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  var _fragmentIndex = 0;
  final _listaCidadesKey = GlobalKey<ListaCidadesFragmentState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(_fragmentIndex == 0 ? ConsultaCepFragment.title :
        ListaCidadesFragment.title),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _fragmentIndex,
          items: const[
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
              label: ConsultaCepFragment.title,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
              label: ListaCidadesFragment.title,
            ),
          ],
        onTap: (int nexIndex){
          if( nexIndex != _fragmentIndex){
            setState(() {
              _fragmentIndex = nexIndex;
            });
          }
        },
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }


  Widget _buildBody() => _fragmentIndex == 0 ? ConsultaCepFragment() :
      ListaCidadesFragment(key:  _listaCidadesKey,);

  Widget? _buildFloatingActionButton(){
    if (_fragmentIndex == 0){
      return null;
    }
    return FloatingActionButton(
      child: Icon(Icons.add),
      tooltip: 'Cadastrar Cidade',
      onPressed: null,
    );
  }

}