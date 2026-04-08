import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/theme_provider.dart';
import '../../theme/theme_tokens.dart';
import '../../widgets/app_card.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.sm),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Theme', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.xs),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.system,
                    groupValue: mode,
                    onChanged: (v) => ref.read(themeModeProvider.notifier).setThemeMode(v!),
                    title: const Text('System'),
                  ),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.light,
                    groupValue: mode,
                    onChanged: (v) => ref.read(themeModeProvider.notifier).setThemeMode(v!),
                    title: const Text('Light'),
                  ),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.dark,
                    groupValue: mode,
                    onChanged: (v) => ref.read(themeModeProvider.notifier).setThemeMode(v!),
                    title: const Text('Dark'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
