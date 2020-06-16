import 'package:covid19_santoamaro/app/models/cidade_model.dart';
import 'package:covid19_santoamaro/app/shared/repositories/covid_repository.dart';
import 'package:mobx/mobx.dart';

part 'stats_controller.g.dart';

class StatsController = _StatsControllerBase with _$StatsController;

abstract class _StatsControllerBase with Store {
  final CovidRepository repository;

  @observable
  ObservableFuture<List<Cidade>> cidade;

  @observable
  String date;

  _StatsControllerBase(this.repository) {
    cidade = repository.getData().asObservable();
  }
}
