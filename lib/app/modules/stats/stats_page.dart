import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:covid19_santoamaro/app/config/pallete.dart';
import 'package:covid19_santoamaro/app/config/styles.dart';
import 'package:covid19_santoamaro/app/models/cidade_model.dart';
import 'package:covid19_santoamaro/app/utils/widgets/custom_app_bar.dart';
import 'package:covid19_santoamaro/app/utils/widgets/stats_grid.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'stats_controller.dart';

class StatsPage extends StatefulWidget {
  final String title;
  const StatsPage({Key key, this.title = "Stats"}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends ModularState<StatsPage, StatsController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.primaryColor,
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(),
          _buildRegionTabBar(),
          // _buildStatsTabBar(controller.date),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Observer(
                    builder: (_) {
                      List list = controller.cidade.value;

                      if (controller.cidade.error != null) {
                        return Center(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Erro',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      if (controller.cidade.value == null) {
                        return Column(
                          children: <Widget>[
                            SizedBox(height: 50),
                            Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ],
                        );
                      }

                      return Column(
                        children: <Widget>[
                          SizedBox(height: 30),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (_, index) {
                              Cidade model = list[index];

                              DateTime todayDate =
                                  DateTime.parse(model.ultimaAtualizacao);

                              String date = formatDate(
                                  todayDate, [dd, '/', mm, '/', yyyy]);

                              return StatsGrid(
                                casos: model.casos.toString(),
                                mortes: model.mortes.toString(),
                                date: date,
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          Text(
                            '* Dados obtidos através do boletim epidemiológico da Secretaria de Saúde do Estado da Bahia (Sesab)',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Acesse: http://www.saude.ba.gov.br/temasdesaude/coronavirus',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Estatísticas',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 1,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Text(
                'Santo Amaro - BA',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
            onTap: (index) {},
          ),
        ),
      ),
    );
  }
}

// SliverPadding _buildStatsTabBar() {
//   return SliverPadding(
//     padding: const EdgeInsets.all(5.0),
//     sliver: SliverToBoxAdapter(
//       child: DefaultTabController(
//         length: 1,
//         child: TabBar(
//           indicatorColor: Colors.transparent,
//           labelStyle: Styles.tabTextStyle,
//           labelColor: Colors.white,
//           unselectedLabelColor: Colors.white60,
//           tabs: <Widget>[
//             Text('Última Atualização em: $date'),
//           ],
//           onTap: (index) {},
//         ),
//       ),
//     ),
//   );
// }
