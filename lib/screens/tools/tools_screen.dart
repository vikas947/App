import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../providers/currency_provider.dart';
import '../../theme/theme_tokens.dart';
import '../../widgets/app_card.dart';

class ToolsScreen extends ConsumerStatefulWidget {
  const ToolsScreen({super.key});

  @override
  ConsumerState<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends ConsumerState<ToolsScreen> {
  final propertyController = TextEditingController(text: '1000');
  bool sqftToSqm = true;

  final fromAmountController = TextEditingController(text: '100');
  String fromCurrency = 'USD';
  String toCurrency = 'INR';

  DateTime? dob;

  @override
  Widget build(BuildContext context) {
    final currencyAsync = ref.watch(currencyRatesProvider);
    final sqValue = double.tryParse(propertyController.text) ?? 0;
    final convertedArea = sqftToSqm ? sqValue * 0.092903 : sqValue * 10.7639;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.sm),
        children: [
          Text('Utility Tools', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Property Calculator', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: AppSpacing.xs),
                TextField(controller: propertyController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Area Value')),
                const SizedBox(height: AppSpacing.xs),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: true, label: Text('Sq.ft → Sq.mt')),
                    ButtonSegment(value: false, label: Text('Sq.mt → Sq.ft')),
                  ],
                  selected: {sqftToSqm},
                  onSelectionChanged: (v) => setState(() => sqftToSqm = v.first),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text('Converted: ${convertedArea.toStringAsFixed(2)}'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Currency Converter', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: AppSpacing.xs),
                currencyAsync.when(
                  loading: () => const CircularProgressIndicator(),
                  error: (_, __) => const Text('Unable to load live rates. Showing cached data when available.'),
                  data: (state) {
                    final rates = state.rates;
                    final amount = double.tryParse(fromAmountController.text) ?? 0;
                    final converted = amount / (rates[fromCurrency] ?? 1) * (rates[toCurrency] ?? 1);
                    final codes = rates.keys.take(20).toList()..sort();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(controller: fromAmountController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Amount')),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: fromCurrency,
                                items: codes.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                                onChanged: (v) => setState(() => fromCurrency = v ?? 'USD'),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: toCurrency,
                                items: codes.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                                onChanged: (v) => setState(() => toCurrency = v ?? 'INR'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text('Converted: ${converted.toStringAsFixed(2)} $toCurrency'),
                        Text('Updated: ${DateFormat('dd MMM, hh:mm a').format(state.updatedAt)}'),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Age Calculator', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: AppSpacing.xs),
                OutlinedButton(
                  onPressed: () async {
                    final now = DateTime.now();
                    final picked = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      lastDate: now,
                      initialDate: DateTime(now.year - 20),
                    );
                    if (picked != null) setState(() => dob = picked);
                  },
                  child: Text(dob == null ? 'Select Date of Birth' : DateFormat('dd MMM yyyy').format(dob!)),
                ),
                if (dob != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(_ageText(dob!)),
                  Text(_nextBirthdayText(dob!)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _ageText(DateTime dob) {
    final now = DateTime.now();
    var years = now.year - dob.year;
    var months = now.month - dob.month;
    var days = now.day - dob.day;
    if (days < 0) {
      months -= 1;
      days += 30;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }
    return 'Age: $years years, $months months, $days days';
  }

  String _nextBirthdayText(DateTime dob) {
    final now = DateTime.now();
    var next = DateTime(now.year, dob.month, dob.day);
    if (!next.isAfter(now)) next = DateTime(now.year + 1, dob.month, dob.day);
    final remaining = next.difference(now).inDays;
    return 'Next birthday in $remaining days';
  }
}
