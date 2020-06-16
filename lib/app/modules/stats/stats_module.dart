import 'package:covid19_santoamaro/app/modules/stats/stats_controller.dart';
import 'package:covid19_santoamaro/app/utils/screens/bottom_nav_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:covid19_santoamaro/app/modules/stats/stats_page.dart';

class StatsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => StatsController(i.get())),
      ];

  @override
  List<Router> get routers => [
        Router('/stats', child: (_, args) => BottomNavScreen()),
      ];

  static Inject get to => Inject<StatsModule>.of();
}
