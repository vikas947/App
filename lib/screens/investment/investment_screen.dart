import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/theme_tokens.dart';
import '../../utils/calculation_utils.dart';
import '../../widgets/app_card.dart';
import '../../widgets/result_tile.dart';

class InvestmentScreen extends StatefulWidget {
  const InvestmentScreen({super.key});

  @override
  State<InvestmentScreen> createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen> {
  bool sipMode = true;
  final amountController = TextEditingController(text: '10000');
  final returnController = TextEditingController(text: '12');
  final durationController = TextEditingController(text: '10');

  @override
  Widget build(BuildContext context) {
    final amount = double.tryParse(amountController.text) ?? 0;
    final rate = double.tryParse(returnController.text) ?? 0;
    final years = int.tryParse(durationController.text) ?? 1;
    final currency = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    final result = sipMode
        ? CalculationUtils.calculateSip(monthlyInvestment: amount, annualReturn: rate, years: years)
        : CalculationUtils.calculateLumpsum(principal: amount, annualReturn: rate, years: years);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.sm),
        children: [
          Text('Investment Calculator', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Column(
              children: [
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: true, label: Text('SIP')),
                    ButtonSegment(value: false, label: Text('Lump Sum')),
                  ],
                  selected: {sipMode},
                  onSelectionChanged: (v) => setState(() => sipMode = v.first),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: sipMode ? 'Monthly Investment' : 'Investment Amount'),
                ),
                const SizedBox(height: AppSpacing.xs),
                TextField(controller: returnController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Expected Return (%)')),
                const SizedBox(height: AppSpacing.xs),
                TextField(controller: durationController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Duration (years)')),
                const SizedBox(height: AppSpacing.sm),
                FilledButton(onPressed: () => setState(() {}), child: const Text('Calculate')), 
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResultTile(label: 'Final Value', value: currency.format(result.finalValue), highlight: true),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ResultTile(label: 'Invested', value: currency.format(result.invested)),
                    ResultTile(label: 'Returns', value: currency.format(result.returns)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: SizedBox(
              height: 240,
              child: LineChart(
                LineChartData(
                  lineTouchData: const LineTouchData(enabled: true),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      barWidth: 4,
                      spots: result.timeline.asMap().entries.map((e) => FlSpot((e.key + 1).toDouble(), e.value)).toList(),
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
