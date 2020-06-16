// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StatsController on _StatsControllerBase, Store {
  final _$cidadeAtom = Atom(name: '_StatsControllerBase.cidade');

  @override
  ObservableFuture<List<Cidade>> get cidade {
    _$cidadeAtom.reportRead();
    return super.cidade;
  }

  @override
  set cidade(ObservableFuture<List<Cidade>> value) {
    _$cidadeAtom.reportWrite(value, super.cidade, () {
      super.cidade = value;
    });
  }

  final _$dateAtom = Atom(name: '_StatsControllerBase.date');

  @override
  String get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(String value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  @override
  String toString() {
    return '''
cidade: ${cidade},
date: ${date}
    ''';
  }
}
