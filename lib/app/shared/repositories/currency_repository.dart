import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:currency_tracker/app/shared/models/Currency.dart';
import 'package:dio/dio.dart';

import '../../app_module.dart';

class CurrencyRepository extends Disposable {
  final Dio _dio = AppModule.to.getDependency<Dio>();

  Future<Currency> fetchCurrencies() async {
    var response = await _dio.get("https://api.exchangeratesapi.io/latest?base=BRL");

    return Currency.fromJson(response.data);
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
