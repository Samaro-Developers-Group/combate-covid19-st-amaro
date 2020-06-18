import 'package:covid19_santoamaro/app/config/pallete.dart';
import 'package:flutter/material.dart';
import 'custom_dialog.dart';
import 'drawer_widget.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  CustomAppBar({Key key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Pallete.primaryColor,
      centerTitle: true,
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.info),
          iconSize: 28.0,
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return CustomDialog(
                  title: 'Fonte e Licença',
                  description1:
                      'Secretarias de Saúde das Unidades Federativas, dados tratados por Álvaro Justen e equipe de voluntários Brasil.IO',
                  description2:
                      'Brasil.IO: boletins epidemiológicos da COVID-19 por município por dia, disponível em: https://brasil.io/dataset/covid19/  acesso em 16 de Junho de 2020).',
                  description3: 'http://www.saude.ba.gov.br/temasdesaude/coronavirus/notas-tecnicas-e-boletins-epidemiologicos-covid-19/',
                );
              },
            );
          },
        ),
      ],
    );
  }
}
