import 'package:currency_tracker/app/shared/models/Rate.dart';
import 'dart:convert';

Currency currencyFromJson(String str) => Currency.fromJson(json.decode(str));

String currencyToJson(Currency data) => json.encode(data.toJson());

class Currency {
  final String base;
  final DateTime date;
  final List<Rate> rates;

  Currency({
    this.rates,
    this.date,
    this.base,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> ratesMap = json['rates'];
    print(ratesMap);

    List<Rate> ratesList = [];

    ratesMap.forEach((k, v) {
      ratesList.add(Rate(name: k, value: v.toDouble()));
    });

    return Currency(
      rates: ratesList,
      base: json['base'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    List<String> keys;
    List<dynamic> values;
    rates.forEach((rate) {
      keys.add(rate.name);
      values.add(rate.value);
    });
    Map<String, dynamic> ratesMap = Map.fromIterables(keys, values);
    return {
      "rates": ratesMap,
      "base": base,
      "date":
          "${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    };
  }
}
