import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/calculation_models.dart';
import '../services/currency_service.dart';

final currencyServiceProvider = Provider((ref) => CurrencyService(Dio()));

final currencyRatesProvider = FutureProvider<CurrencyState>((ref) async {
  final service = ref.watch(currencyServiceProvider);
  return service.getRates();
});
