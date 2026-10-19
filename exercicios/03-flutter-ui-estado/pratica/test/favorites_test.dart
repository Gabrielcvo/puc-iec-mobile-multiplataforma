// Ex3 · TASK 9 — teste unitário do `favoritesProvider`, ISOLADO (sem UI).
//
// ProviderContainer = um "mini-app" para testar o provider sem tela.
// Obs.: no `flutter test` o Firebase não sobe — o provider captura o erro
// ("No Firebase App") e segue só com o estado local, que é o que testamos aqui.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filmes_flutter/state/favorites.dart';

void main() {
  test('favoritos: toggle e clear', () {
    final c = ProviderContainer();
    addTearDown(c.dispose);

    expect(c.read(favoritesProvider), isEmpty);

    c.read(favoritesProvider.notifier).toggle(1);
    expect(c.read(favoritesProvider).contains(1), isTrue);

    c.read(favoritesProvider.notifier).toggle(1); // de novo → remove
    expect(c.read(favoritesProvider).contains(1), isFalse);
    expect(c.read(favoritesProvider), isEmpty);

    c.read(favoritesProvider.notifier)
      ..toggle(1)
      ..toggle(2);
    expect(c.read(favoritesProvider), {1, 2});

    c.read(favoritesProvider.notifier).clear(); // clear → esvazia
    expect(c.read(favoritesProvider), isEmpty);
  });

  test('favoritos: ids diferentes são independentes', () {
    final c = ProviderContainer();
    addTearDown(c.dispose);

    final n = c.read(favoritesProvider.notifier);
    n.toggle(1);
    n.toggle(2);
    n.toggle(1); // remove só o 1

    expect(c.read(favoritesProvider), {2});
  });
}
