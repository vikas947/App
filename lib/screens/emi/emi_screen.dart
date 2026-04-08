import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/theme_tokens.dart';
import '../../utils/calculation_utils.dart';
import '../../widgets/app_card.dart';
import '../../widgets/result_tile.dart';

class EmiScreen extends StatefulWidget {
  const EmiScreen({super.key});

  @override
  State<EmiScreen> createState() => _EmiScreenState();
}

class _EmiScreenState extends State<EmiScreen> {
  final loanController = TextEditingController(text: '1200000');
  final rateController = TextEditingController(text: '8.5');
  final tenureController = TextEditingController(text: '240');
  bool reducing = true;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    final loan = double.tryParse(loanController.text) ?? 0;
    final rate = double.tryParse(rateController.text) ?? 0;
    final tenure = int.tryParse(tenureController.text) ?? 1;
    final result = CalculationUtils.calculateEmi(
      principal: loan,
      annualRate: rate,
      tenureMonths: tenure,
      reducing: reducing,
    );

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.sm),
        children: [
          Text('EMI Calculator', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Column(
              children: [
                TextField(controller: loanController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Loan Amount')),
                const SizedBox(height: AppSpacing.xs),
                TextField(controller: rateController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Interest Rate (%)')),
                const SizedBox(height: AppSpacing.xs),
                TextField(controller: tenureController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Tenure (months)')),
                const SizedBox(height: AppSpacing.sm),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: true, label: Text('Reducing')),
                    ButtonSegment(value: false, label: Text('Fixed')),
                  ],
                  selected: {reducing},
                  onSelectionChanged: (value) => setState(() => reducing = value.first),
                ),
                const SizedBox(height: AppSpacing.sm),
                FilledButton(
                  onPressed: () => setState(() {}),
                  child: const Text('Calculate EMI'),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResultTile(label: 'Monthly EMI', value: currency.format(result.emi), highlight: true),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ResultTile(label: 'Total Interest', value: currency.format(result.totalInterest)),
                    ResultTile(label: 'Total Payment', value: currency.format(result.totalPayment)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: SizedBox(
              height: 220,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 48,
                  sectionsSpace: 4,
                  sections: [
                    PieChartSectionData(value: loan, title: 'Principal', radius: 54),
                    PieChartSectionData(value: result.totalInterest, title: 'Interest', radius: 54),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      barWidth: 3,
                      spots: List.generate(
                        12,
                        (i) => FlSpot(i.toDouble(), (result.emi + (i * result.emi * 0.003)).toDouble()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
