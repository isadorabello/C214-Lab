import 'package:test/test.dart';
import 'package:teste_unitario/classe_extra.dart';

void main() {
  test('Name value should change to -Karol Lima-', () {
    final nomeTeste = NomeAluno();

    nomeTeste.alterarNome();

    expect(nomeTeste.nome, 'Karol Lima');
  });

  test('Name value should change to empty space', () {
    final nomeTeste = NomeAluno();

    nomeTeste.limparNome();

    expect(nomeTeste.nome, ' ');
  });
}
