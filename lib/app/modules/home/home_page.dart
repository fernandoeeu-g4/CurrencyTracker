import 'package:currency_tracker/app/app_module.dart';
import 'package:currency_tracker/app/app_bloc.dart';
import 'package:currency_tracker/app/modules/home/components/base_currency_card.dart';
import 'package:currency_tracker/app/modules/home/components/favorites_list.dart';
import 'package:currency_tracker/app/shared/components/menu_drawer.dart';
import 'package:currency_tracker/app/shared/models/Currency.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;
  HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _appBloc = AppModule.to.getBloc<AppBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F9FF),
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext ctx) => [
              const PopupMenuItem(
                value: 1,
                child: Text('Adicionar nova moeda'),
              ),
            ],
          )
        ],
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black, fontSize: 26),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 16),
            StreamBuilder(
              stream: _appBloc.currenciesListOut,
              builder: (BuildContext ctx, AsyncSnapshot<Currency> currency) {
                if (currency.hasData) {
                  return Column(
                    children: <Widget>[
                      BaseCurrencyCard(),
                      const SizedBox(height: 16),
                      FavoritesList(),
                    ],
                  );
                } else {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      drawer: MenuDrawer(),
    );
  }
}
