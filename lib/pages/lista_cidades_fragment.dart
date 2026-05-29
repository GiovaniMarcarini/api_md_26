

import 'package:api_md_26/model/cidade.dart';
import 'package:api_md_26/services/cidade_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListaCidadesFragment extends StatefulWidget{
  static const title = 'Cidades';

  const ListaCidadesFragment({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => ListaCidadesFragmentState();
}

class ListaCidadesFragmentState extends State<ListaCidadesFragment>{

  final _service = CidadeService();
  final List<Cidade> _cidades = [];
  final _refreshidicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _refreshidicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context){
    return Padding(
        padding: EdgeInsets.all(10),
      child: LayoutBuilder(
          builder: (_, constraints) {
            Widget content;
            if (_cidades.isEmpty) {
              content = SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: Center(
                      child: Text('Nenhuma cidade cadastrada'),
                    )
                ),
              );
            }else {
              content = ListView.separated(
                  itemBuilder: (_, index) {
                    final cidade = _cidades[index];
                    return ListTile(
                      title: Text('${cidade.nome} - ${cidade.uf}'),
                      onTap: () => _mostrarDialogActions(cidade),
                    );
                  },
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: _cidades.length
              );
            }
            return RefreshIndicator(
              key: _refreshidicatorKey,
              onRefresh: findCidades,
              child: content,
            );
          }
      ),
    );
  }
  
  Future<void> findCidades() async {
    await Future.delayed(Duration(seconds: 2));
    final cidades = await _service.findCidades();
    setState(() {
      _cidades.clear();
      if(cidades.isNotEmpty){
        _cidades.addAll(cidades);
      }
    });
  }

  void _mostrarDialogActions(Cidade cidade){
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('${cidade.nome} - ${cidade.uf}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Editar'),
                onTap: null,
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Deletar'),
                onTap: null,
              ),
            ],
          ),
          
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(), 
                child: Text('Cancelar')
            )
          ],
    ),
    );
  }
}