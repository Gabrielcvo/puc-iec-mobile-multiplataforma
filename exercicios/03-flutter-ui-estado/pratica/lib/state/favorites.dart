// lib/state/favorites.dart
//
// Ex2 (TASK 2): estado compartilhado de favoritos com Riverpod.
// Ex4 (TASK 7): o mesmo provider, agora sincronizado com o Firestore (cloud).
//
// A interface é a mesma da TASK 2 (toggle/clear) — só muda a fonte de verdade:
// o Set<int> em memória continua refletindo na UI na hora (otimista) e cada mudança
// é gravada no documento `favorites/meus-favoritos`.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart'; // debugPrint
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _favDoc = 'favorites/meus-favoritos'; // 1 documento por aluno (seu projeto = seu Firestore)

class FavoritesNotifier extends Notifier<Set<int>> {
  @override
  Set<int> build() {
    _load(); // dispara a leitura async; o state começa vazio até o Firestore responder
    return {};
  }

  Future<void> _load() async {
    try {
      final doc = await FirebaseFirestore.instance.doc(_favDoc).get();
      final raw = doc.data()?['ids'] as List<dynamic>? ?? const <dynamic>[];
      state = raw.whereType<num>().map((e) => e.toInt()).toSet();
    } catch (e) {
      // offline, ou `flutter test` ("No Firebase App" — esperado): mantém vazio.
      // `permission-denied` no console = revise as REGRAS do Firestore.
      debugPrint('Firestore (ler): $e');
    }
  }

  Future<void> _persist(Set<int> next) async {
    try {
      await FirebaseFirestore.instance.doc(_favDoc).set({'ids': next.toList()});
    } catch (e) {
      // offline, ou `flutter test`: tudo bem, o estado local já refletiu a mudança na UI.
      debugPrint('Firestore (gravar): $e'); // `permission-denied` = regras
    }
  }

  void toggle(int id) {
    final next = state.contains(id) ? ({...state}..remove(id)) : {...state, id};
    state = next; // UI reage na hora (otimista)
    _persist(next); // grava no Firestore em paralelo
  }

  void clear() {
    state = {};
    _persist({});
  }
}

final favoritesProvider =
    NotifierProvider<FavoritesNotifier, Set<int>>(FavoritesNotifier.new);
