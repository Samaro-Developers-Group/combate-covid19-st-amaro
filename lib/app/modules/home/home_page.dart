import 'package:covid19_santoamaro/app/config/data.dart';
import 'package:covid19_santoamaro/app/config/pallete.dart';
import 'package:covid19_santoamaro/app/config/styles.dart';
import 'package:covid19_santoamaro/app/utils/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_controller.dart';
import 'package:covid19_santoamaro/app/utils/widgets/drawer_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  final Function onTap;
  const HomePage({Key key, this.onTap, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      drawer: DrawerWidget(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(screenHeight, context),
          _buildPreventionTips(screenHeight),
        ],
      ),
    );
  }
}

SliverToBoxAdapter _buildHeader(double screenHeight, BuildContext context) {
  return SliverToBoxAdapter(
    child: Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Pallete.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'COVID-19 | Santo Amaro',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Dúvidas?',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Se estiver com alguma dúvida, por favor entre em contato com a central de atendimento da Sec. de Saúde.',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Contato',
                      style: Styles.buttonTextStyle,
                    ),
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}

showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: Text(
          'Contatos',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Pallete.primaryColor,
              child: Text('Voltar'),
              onPressed: () {
                Modular.to.pop();
              },
            ),
          ),
        ],
        content: Container(
          height: 100,
          width: 100,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.call,
                  color: Colors.grey,
                ),
                onTap: () {
                  return launch("tel://32412315");
                },
                title: Text(
                  '(75) 3241-2315',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              ListTile(
                leading: Tab(
                  icon: Container(
                    width: 30,
                    height: 30,
                    child: Image.asset(
                      'images/zapes.png',
                    ),
                  ),
                ),
                onTap: () async {
                  var phone = "+5575992680394";
                  var whatsappUrl = "whatsapp://send?phone=$phone";
                  await canLaunch(whatsappUrl)
                      ? launch(whatsappUrl)
                      : print(
                          "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
                },
                title: Text(
                  '(75) 99268-0394',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

SliverToBoxAdapter _buildPreventionTips(double screenHeight) {
  return SliverToBoxAdapter(
    child: Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Dicas de Prevenção',
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: prevention
                .map((e) => Column(
                      children: <Widget>[
                        Image.asset(
                          e.keys.first,
                          height: screenHeight * 0.12,
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Text(
                          e.values.first,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    ),
  );
}

// return Scaffold(
//   body: Observer(
//     builder: (_) {

//       List list = controller.cidade.value;

//       return ListView.builder(
//         itemCount: list.length,
//         itemBuilder: (_, index) {
//           Cidade model = list[index];

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Header(),
//               const SizedBox(height: 20.0),
//               Padding(
//                 padding: const EdgeInsets.only(left: 16.0),
//                 child: Text(
//                   'Dados Atualizados em: $date',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 18.0),
//                 ),
//               ),
//               Card(
//                 elevation: 4.0,
//                 color: Colors.white,
//                 margin: const EdgeInsets.all(15.0),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: ListTile(
//                         leading: Container(
//                           alignment: Alignment.bottomCenter,
//                           width: 45.0,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: <Widget>[
//                               Container(
//                                 height: 20,
//                                 width: 8.0,
//                                 color: Colors.grey.shade300,
//                               ),
//                               const SizedBox(width: 4.0),
//                               Container(
//                                 height: 25,
//                                 width: 8.0,
//                                 color: Colors.grey.shade300,
//                               ),
//                               const SizedBox(width: 4.0),
//                               Container(
//                                 height: 40,
//                                 width: 8.0,
//                                 color: Colors.blue,
//                               ),
//                               const SizedBox(width: 4.0),
//                               Container(
//                                 height: 30,
//                                 width: 8.0,
//                                 color: Colors.grey.shade300,
//                               ),
//                             ],
//                           ),
//                         ),
//                         title: Text("População de Santo Amaro"),
//                         subtitle: Text(
//                           '${model.populacao.toString()} (dados do IBGE de 2019)',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               DataComponent(
//                 color: Colors.green,
//                 icon: Icons.person_outline,
//                 title: "Total de Casos Confirmados",
//                 data: model.casos.toString(),
//               ),
//               const SizedBox(height: 16.0),
//               DataComponent(
//                 color: Colors.red,
//                 icon: Icons.person_pin,
//                 title: "Total de Casos Confirmados",
//                 data: model.mortes.toString(),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   ),
// );
