import 'package:covid19_santoamaro/app/config/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => new _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int itemSelect = 0;

  Widget _listMenu() {
    return ListView(
      children: <Widget>[
        _avatar(),
        _tiles("INÍCIO", Icons.home, 1, Colors.amber, () {
          Modular.to.pop();
        }),
        _tiles(
          "CONTATO",
          Icons.contacts,
          2,
          Colors.blue,
          () {
            return showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  title: Text(
                    'Contato',
                    textAlign: TextAlign.center,
                  ),
                  content: Container(
                    height: 200,
                    width: 200,
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.mail,
                            color: Colors.red,
                          ),
                          title: Text(
                            'felipeme73@gmail.com',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Tab(
                            icon: Container(
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                'images/git.png',
                              ),
                            ),
                          ),
                          title: Text(
                            'github.com/felipesses',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Tab(
                            icon: Container(
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                'images/linkedin.png',
                              ),
                            ),
                          ),
                          title: Text(
                            'https://www.linkedin.com/in/felipemagalhaes13/',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        _tiles("MAIS INFORMAÇÕES", Icons.info, 3, Colors.purple, () {}),
        Divider(),
        _tiles("SAIR", Icons.arrow_back, 4, Colors.black, () {
          SystemNavigator.pop();
        }),
      ],
    );
  }

//cria cada item do menu
  Widget _tiles(
      String text, IconData icon, int item, Color colorIcon, Function onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: colorIcon,
      ),
      onTap: onTap,
      selected: item == itemSelect,
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  //cria o avatar com nome, email e imagem
  Widget _avatar() {
    return Padding(
      padding: EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.blue.shade800,
            child: Text(
              'F',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            radius: 25,
          ),
          Container(
            height: 12.0,
          ),
          Text(
            "Felipe Magalhães Pereira",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Pallete.primaryColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "felipeme73@gmail.com",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: _listMenu(),
      ),
    );
  }
}
