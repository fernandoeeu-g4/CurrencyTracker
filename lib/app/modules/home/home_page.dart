import 'package:currency_tracker/app/app_module.dart';
import 'package:currency_tracker/app/app_bloc.dart';
import 'package:currency_tracker/app/modules/home/components/base_currency_card.dart';
import 'package:currency_tracker/app/modules/home/components/currency_status_card.dart';
import 'package:currency_tracker/app/shared/models/Currency.dart';
import 'package:currency_tracker/app/shared/theme/styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;
  HomePage({Key key, this.title = "Home"}) : super(key: key);

  final _appBloc = AppModule.to.getBloc<AppBloc>();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                StreamBuilder(
                  stream: AppModule.to.getBloc<AppBloc>().defaultCurrencyOut,
                  builder: (BuildContext context,
                      AsyncSnapshot<String> defaultCurrency) {
                    if (defaultCurrency.hasData) {
                      return StreamBuilder(
                        stream:
                            AppModule.to.getBloc<AppBloc>().currenciesListOut,
                        builder: (BuildContext ctx,
                            AsyncSnapshot<Currency> currency) {
                          if (currency.hasData) {
                            return Column(
                              children: <Widget>[
                                // DropdownButton(
                                //   value: defaultCurrency.data,
                                //   icon: Icon(Icons.arrow_downward),
                                //   onChanged: (String newValue) {
                                //     print(newValue);
                                //   },
                                //   items: currency.data.rates.map((rate) {
                                //     return DropdownMenuItem<String>(
                                //         value: rate.name,
                                //         child: Text(rate.name));
                                //   }).toList(),
                                // ),
                                BaseCurrencyCard(),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    boxShadow: Styles.defaultBoxShadow(shadowColor: Color(0xffEFEAF5)),
                                  ),
                                  child: RaisedButton(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text('Adicionar nova moeda', style: TextStyle(fontSize: 22.0),),
                                    ),
                                    onPressed: () {},
                                    color: Color(0xffEFEAF5),
                                    elevation: 0,
                                    splashColor: Color(0xff62319E),
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height / 1.5,
                                  child: ListView.builder(
                                    itemCount: 10,
                                    itemBuilder: (BuildContext ctx, int index) {
                                      return CurrencyStatusCard();
                                    },
                                  ),
                                )
                              ],
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      );
                    }
                    return CircularProgressIndicator();
                  },
                )
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
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
        )),
      ),
    );
  }
}
