import 'package:flutter/material.dart';

class ResultTile extends StatelessWidget {
  const ResultTile({
    super.key,
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall),
        const SizedBox(height: 8),
        Text(
          value,
          style: (highlight ? theme.textTheme.headlineMedium : theme.textTheme.titleLarge)
              ?.copyWith(fontWeight: highlight ? FontWeight.w800 : FontWeight.w600),
        ),
      ],
    );
  }
}
