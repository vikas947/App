import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/calculation_models.dart';

class CurrencyService {
  CurrencyService(this._dio);

  final Dio _dio;
  static const _cacheKey = 'currency_cache';

  Future<CurrencyState> getRates({String base = 'USD'}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        'https://open.er-api.com/v6/latest/$base',
      );
      final rates = (response.data?['rates'] as Map).map(
        (key, value) => MapEntry(key.toString(), (value as num).toDouble()),
      );
      final now = DateTime.now();
      final cache = jsonEncode({
        'updatedAt': now.toIso8601String(),
        'rates': rates,
      });
      await prefs.setString(_cacheKey, cache);
      return CurrencyState(rates: rates, updatedAt: now);
    } catch (_) {
      final cached = prefs.getString(_cacheKey);
      if (cached == null) rethrow;
      final map = jsonDecode(cached) as Map<String, dynamic>;
      final rates = (map['rates'] as Map).map(
        (key, value) => MapEntry(key.toString(), (value as num).toDouble()),
      );
      return CurrencyState(
        rates: rates,
        updatedAt: DateTime.parse(map['updatedAt'] as String),
      );
    }
  }
}
