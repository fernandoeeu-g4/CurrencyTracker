import 'package:flutter/material.dart';

import '../../../app_bloc.dart';
import '../../../app_module.dart';
import '../../../shared/models/Rate.dart';
import 'currency_status_card.dart';

class FavoritesList extends StatelessWidget {
  final _appBloc = AppModule.to.getBloc<AppBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      child: StreamBuilder(
        stream: _appBloc.favoritesListOut,
        builder: (context, AsyncSnapshot<List<Rate>> favorites) {
          if (favorites.hasData) {
            return ListView.builder(
              itemCount: favorites.data.length,
              itemBuilder: (BuildContext ctx, int index) {
                return CurrencyStatusCard(
                  favorite: favorites.data[index],
                );
              },
            );
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
