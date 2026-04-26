import 'dart:ui';
import 'package:flutter/material.dart';
import '../../features/timer/screens/timer_screen.dart';
import '../../features/shield/screens/shield_screen.dart';
import '../../features/log/screens/log_screen.dart';
import '../../features/settings/screens/settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    TimerScreen(),
    ShieldScreen(),
    LogScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      extendBody: true, // Crucial for the blur effect to show the content behind
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: colorScheme.outlineVariant.withValues(alpha: 0.1),
              width: 0.5,
            ),
          ),
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              backgroundColor: colorScheme.surface.withValues(alpha: 0.8),
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.timer_outlined, size: 28),
                  activeIcon: Icon(Icons.timer, size: 28),
                  label: 'Timer',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shield_outlined, size: 26),
                  activeIcon: Icon(Icons.shield, size: 26),
                  label: 'Shield',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined, size: 24),
                  activeIcon: Icon(Icons.calendar_today, size: 24),
                  label: 'Calendar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined, size: 26),
                  activeIcon: Icon(Icons.settings, size: 26),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
