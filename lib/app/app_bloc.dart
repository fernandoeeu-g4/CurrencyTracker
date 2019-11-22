import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:currency_tracker/app/app_module.dart';
import 'package:currency_tracker/app/shared/models/Currency.dart';
import 'package:currency_tracker/app/shared/repositories/currency_repository.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {
  BehaviorSubject<String> _defaultCurrencyController$ = BehaviorSubject<String>.seeded('BRL');
  BehaviorSubject<Currency> _currenciesListController$ = BehaviorSubject<Currency>();
  BehaviorSubject<List<String>> _favoritesCurrenciesController$ = BehaviorSubject<List<String>>.seeded(['USD', 'JPY']);

  // possibilita o uso externamente também
  Observable<String> get defaultCurrencyOut => _defaultCurrencyController$.stream;
  Sink<String> get defaultCurrencyIn => _defaultCurrencyController$.sink;
  Observable<Currency> get currenciesListOut => _currenciesListController$.stream;
  Sink<Currency> get currenciesListIn => _currenciesListController$.sink;


  void setDefaultCurrency ( String currency ) => defaultCurrencyIn.add(currency);

  final _currencyRepository = AppModule.to.getDependency<CurrencyRepository>();

  AppBloc() {
    _currencyRepository.fetchCurrencies().then((res) => currenciesListIn.add(res));

  }

  @override
  void dispose() {
    super.dispose();
    _defaultCurrencyController$.close();
    _currenciesListController$.close();
    _favoritesCurrenciesController$.close();
  }
}
