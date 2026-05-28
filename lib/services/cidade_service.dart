

import 'dart:convert';

import 'package:api_md_26/model/cidade.dart';
import 'package:http/http.dart';

class CidadeService {

  static const _baseUrl = 'http://cloud.colegiomaterdei.com.br:8090/cidades';

  Future<List<Cidade>> findCidades() async {
    final uri = Uri.parse(_baseUrl);
    final Response response = await get(uri);

    if(response.statusCode != 200 || response.body.isEmpty){
      throw Exception();
    }

    final decoBody = json.decode(response.body) as List;

    return decoBody
        .map((e) => Cidade.fromJson(Map<String, dynamic>.from(e))).toList();
  }
}