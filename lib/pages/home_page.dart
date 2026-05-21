

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

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(_fragmentIndex == 0 ? ConsultaCepFragment.title :
        ListaCidadesFragment.title),
      ),
      body: _buildBody(),
    );
  }


  Widget _buildBody() => _fragmentIndex == 0 ? ConsultaCepFragment() :
      ListaCidadesFragment();

}