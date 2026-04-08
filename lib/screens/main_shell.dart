import 'package:flutter/material.dart';

import 'emi/emi_screen.dart';
import 'home/home_screen.dart';
import 'investment/investment_screen.dart';
import 'settings/settings_screen.dart';
import 'tools/tools_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  late final PageController _controller;

  static const pages = [
    HomeScreen(),
    EmiScreen(),
    InvestmentScreen(),
    ToolsScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => setState(() => index = value),
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) {
          setState(() => index = v);
          _controller.animateToPage(
            v,
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
          );
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.payments_outlined), label: 'EMI'),
          NavigationDestination(icon: Icon(Icons.trending_up_outlined), label: 'Investment'),
          NavigationDestination(icon: Icon(Icons.handyman_outlined), label: 'Tools'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
    );
  }
}
