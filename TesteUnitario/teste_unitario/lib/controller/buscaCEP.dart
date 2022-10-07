import 'package:teste_unitario/model/estado.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Estado> buscarCEP([client]) async {
  final response =
      await http.get(Uri.parse('https://viacep.com.br/ws/37701000/json/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Estado.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Estado> buscarNovoCEP(String cep) async {
  final response =
      await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Estado.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
