import 'package:covid19_santoamaro/app/models/cidade_model.dart';
import 'package:covid19_santoamaro/app/shared/repositories/covid_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {}
