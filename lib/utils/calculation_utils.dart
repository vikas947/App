import 'dart:math';

import '../models/calculation_models.dart';

class CalculationUtils {
  static EmiResult calculateEmi({
    required double principal,
    required double annualRate,
    required int tenureMonths,
    required bool reducing,
  }) {
    final monthlyRate = annualRate / 12 / 100;
    if (reducing) {
      final factor = pow(1 + monthlyRate, tenureMonths);
      final emi = principal * monthlyRate * factor / (factor - 1);
      final totalPayment = emi * tenureMonths;
      return EmiResult(
        emi: emi,
        totalInterest: totalPayment - principal,
        totalPayment: totalPayment,
      );
    }
    final totalInterest = principal * (annualRate / 100) * (tenureMonths / 12);
    final totalPayment = principal + totalInterest;
    return EmiResult(
      emi: totalPayment / tenureMonths,
      totalInterest: totalInterest,
      totalPayment: totalPayment,
    );
  }

  static InvestmentResult calculateSip({
    required double monthlyInvestment,
    required double annualReturn,
    required int years,
  }) {
    final r = annualReturn / 12 / 100;
    final months = years * 12;
    final timeline = <double>[];
    for (var y = 1; y <= years; y++) {
      final m = y * 12;
      final fv = monthlyInvestment * ((pow(1 + r, m) - 1) / r) * (1 + r);
      timeline.add(fv.toDouble());
    }
    final finalValue = monthlyInvestment * ((pow(1 + r, months) - 1) / r) * (1 + r);
    final invested = monthlyInvestment * months;
    return InvestmentResult(
      invested: invested,
      returns: finalValue - invested,
      finalValue: finalValue.toDouble(),
      timeline: timeline,
    );
  }

  static InvestmentResult calculateLumpsum({
    required double principal,
    required double annualReturn,
    required int years,
  }) {
    final timeline = <double>[];
    for (var y = 1; y <= years; y++) {
      timeline.add(principal * pow(1 + annualReturn / 100, y));
    }
    final finalValue = principal * pow(1 + annualReturn / 100, years);
    return InvestmentResult(
      invested: principal,
      returns: finalValue - principal,
      finalValue: finalValue.toDouble(),
      timeline: timeline,
    );
  }
}
