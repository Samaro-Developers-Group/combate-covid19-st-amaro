import 'package:covid19_santoamaro/app/app_controller.dart';
import 'package:covid19_santoamaro/app/modules/stats/stats_controller.dart';
import 'package:covid19_santoamaro/app/modules/stats/stats_module.dart';
import 'package:covid19_santoamaro/app/shared/repositories/covid_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:covid19_santoamaro/app/app_widget.dart';
import 'package:covid19_santoamaro/app/modules/home/home_module.dart';

import 'modules/home/home_controller.dart';
import 'utils/constants.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => HomeController()),
        Bind((i) => StatsController(i.get())),
        Bind((i) => CovidRepository(i.get())),
        Bind(
          (i) => Dio(
            BaseOptions(
              baseUrl: URL_PATH,
              responseType: ResponseType.plain,
              connectTimeout: 30000,
              receiveTimeout: 30000,
            ),
          ),
        ),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, module: HomeModule()),
        Router('/stats', module: StatsModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
