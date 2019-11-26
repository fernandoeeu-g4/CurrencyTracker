import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('Início'),
                leading: Icon(Icons.home),
              ),
              ListTile(
                title: Text('Configurações'),
                leading: Icon(Icons.settings),
              )
            ],
          ),
        ),
      ),
    );
  }
}
