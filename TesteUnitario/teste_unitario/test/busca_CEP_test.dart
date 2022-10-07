import 'package:teste_unitario/controller/buscaCEP.dart';
import 'package:teste_unitario/model/estado.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'busca_CEP_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('buscarCEP', () {
    test('returns a zpicode if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('https://viacep.com.br/ws/37701000/json/')))
          .thenAnswer((_) async => http.Response(
              '{"cep": "37701-000", "logradouro": "Rua Assis Figueiredo", "complemento": "de 794/795 a 1105/1106", "bairro":"Centro", "localidade":"Poços de Caldas", "uf":"MG", "ibge":"3151800", "gia":"", "ddd":"35", "siafi":"5035"}',
              200));

      expect(await buscarCEP(client), isA<Estado>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('https://viacep.com.br/ws/37701000/json/')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(buscarCEP(client), throwsException);
    });
  });
}
