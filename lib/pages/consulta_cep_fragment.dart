

import 'package:api_md_26/services/cep_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../model/cep.dart';

class ConsultaCepFragment extends StatefulWidget{
  static const title = 'Buscar CEP';

  @override
  State<StatefulWidget> createState() => _ConsultaCepFragmentState();
}

class _ConsultaCepFragmentState extends State<ConsultaCepFragment>{

  final _service = CepService();
  final _textEditingController = TextEditingController();
  var _loading = false;
  final _formKey = GlobalKey<FormState>();
  final _cepFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {'#' : RegExp(r'[0-9]')}
  );

  Cep? _cep;

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'CEP',
                suffixIcon: _loading
                    ? Padding(
                  padding: EdgeInsets.all(10),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
                    : IconButton(
                  onPressed: _findCep,
                  icon: Icon(Icons.search),
                ),
              ),
              inputFormatters: [_cepFormatter],
              validator: (String? value) {
                if (value == null ||
                    value.isEmpty ||
                    !_cepFormatter.isFill()) {
                  return 'Informe um CEP válido';
                }
                return null;
              },
            ),
          ),
          Container(height: 20),
          ..._buildResultWidgets(),
        ],
      ),
    );
  }

  Future<void> _findCep() async {
    if(_formKey.currentState == null || !_formKey.currentState!.validate()){
      return;
    }
    setState(() {
      _loading = true;
    });
    try{
      _cep = await _service.findCepAsObject(_cepFormatter.getUnmaskedText());
    }catch(e){
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Ocorreu um erro ao buscar o CEP, tente novamente!')
      ));
    }
    setState(() {
      _loading = false;
    });
  }

  List<Widget> _buildResultWidgets(){
    final List<Widget> widgts = [];
    if (_cep != null){
      final map = _cep!.toJson();
      for (final key in map.keys){
        widgts.add(
          Text('$key : ${map[key]}')
        );
      }
    }
    return widgts;
  }
}