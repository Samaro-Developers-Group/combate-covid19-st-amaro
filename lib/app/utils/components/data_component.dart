import 'package:flutter/material.dart';

class DataComponent extends StatelessWidget {
  final Color color;
  final String data;
  final String title;
  final IconData icon;

  const DataComponent({Key key, this.icon, this.color, this.data, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: _buildTile(
              color: color,
              icon: icon,
              title: title,
              data: data.toString(),
            ),
          )
        ],
      ),
    );
  }

  Container _buildTile(
      {Color color, IconData icon, String title, String data}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: Icon(
              icon,
              color: Colors.white,
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              data,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 25.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
