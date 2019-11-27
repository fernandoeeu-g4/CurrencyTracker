import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:currency_tracker/app/app_module.dart';
import 'package:currency_tracker/app/shared/models/Currency.dart';
import 'package:currency_tracker/app/shared/repositories/currency_repository.dart';
import 'package:rxdart/rxdart.dart';

import 'shared/models/Rate.dart';

class AppBloc extends BlocBase {
  BehaviorSubject<String> _defaultCurrencyController$ =
      BehaviorSubject<String>.seeded('BRL');
  BehaviorSubject<Currency> _currenciesListController$ =
      BehaviorSubject<Currency>();
  BehaviorSubject<List<Rate>> _favoritesCurrenciesController$ =
      BehaviorSubject<List<Rate>>();
  BehaviorSubject<double> _globalAmount$ = BehaviorSubject<double>.seeded(100.0);

  // possibilita o uso externamente também
  Observable<double> get globalAmountOut => _globalAmount$.stream;
  Sink<double> get globalAmountIn => _globalAmount$.sink;
  Observable<String> get defaultCurrencyOut =>
      _defaultCurrencyController$.stream;
  Sink<String> get defaultCurrencyIn => _defaultCurrencyController$.sink;
  Observable<Currency> get currenciesListOut =>
      _currenciesListController$.stream;
  Sink<Currency> get currenciesListIn => _currenciesListController$.sink;
  Observable<List<Rate>> get favoritesListOut =>
      _favoritesCurrenciesController$.stream;
  Sink<List<Rate>> get favoritesListIn => _favoritesCurrenciesController$.sink;

  void setDefaultCurrency(String currency) => defaultCurrencyIn.add(currency);
  void setGlobalAmount(double newAmount) => globalAmountIn.add(newAmount);

  final _currencyRepository = AppModule.to.getDependency<CurrencyRepository>();

  AppBloc() {
    fetchCurrencies();
  }

  void fetchCurrencies() async {
    var currency = await _currencyRepository.fetchCurrencies();
    currenciesListIn.add(currency);

    // TODO: Obter as moedas favoritas salvas no Hive ou SharedPreferences e adicionar em favoritesListIn.
    // Caso o usuário não tenha nenhuma moeda favorita, adicionar as default declaradas abaixo.

    // Essas são as moedas default (para quando o usuário ainda não adicionou nenhuma como favorita)
    var defaultFavorites = currency.rates
        .where((rate) => rate.name == 'USD' || rate.name == 'JPY')
        .toList();
    favoritesListIn.add(defaultFavorites);
  }

  @override
  void dispose() {
    super.dispose();
    _defaultCurrencyController$.close();
    _currenciesListController$.close();
    _favoritesCurrenciesController$.close();
    _globalAmount$.close();
  }
}
