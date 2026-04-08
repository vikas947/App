import 'package:flutter/material.dart';

import '../../theme/theme_tokens.dart';
import '../../widgets/app_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('EMI', Icons.payments_outlined),
      ('Investment', Icons.trending_up_outlined),
      ('Property', Icons.apartment_outlined),
      ('Currency', Icons.currency_exchange_outlined),
      ('Age', Icons.cake_outlined),
      ('Basic Calculator', Icons.calculate_outlined),
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Financial Tools', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.sm),
            GridView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.sm,
                crossAxisSpacing: AppSpacing.sm,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(item.$2, size: 28),
                      Text(item.$1, style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Recent Calculations', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => SizedBox(
                  width: 180,
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('EMI #$index', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Text('\$ ${(2400 + index * 310).toStringAsFixed(0)}'),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
                itemCount: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
