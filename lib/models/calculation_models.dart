class EmiResult {
  const EmiResult({
    required this.emi,
    required this.totalInterest,
    required this.totalPayment,
  });

  final double emi;
  final double totalInterest;
  final double totalPayment;
}

class InvestmentResult {
  const InvestmentResult({
    required this.invested,
    required this.returns,
    required this.finalValue,
    required this.timeline,
  });

  final double invested;
  final double returns;
  final double finalValue;
  final List<double> timeline;
}

class CurrencyState {
  const CurrencyState({
    required this.rates,
    required this.updatedAt,
  });

  final Map<String, double> rates;
  final DateTime updatedAt;
}
