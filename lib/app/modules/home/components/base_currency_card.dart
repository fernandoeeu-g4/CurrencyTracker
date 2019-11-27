import 'package:currency_tracker/app/shared/theme/styles.dart';
import 'package:flutter/material.dart';

class BaseCurrencyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
        boxShadow: Styles.defaultBoxShadow(),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Moeda base',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  'BRL',
                  style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter a search term',
                  ),
                  onChanged: (text) {
                    print("First text field: $text");
                  },
                ),
              ],
            ),
          ],
        )
      ]),
    );
  }
}
