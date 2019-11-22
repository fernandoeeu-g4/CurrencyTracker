import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:currency_tracker/app/shared/models/Currency.dart';
import 'package:dio/dio.dart';

class CurrencyRepository extends Disposable {
  Future<Currency> fetchCurrencies() async {
    var response = await Dio().get("https://api.exchangeratesapi.io/latest");

     return Currency.fromJson(response.data);
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
