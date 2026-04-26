import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Duration _focusDuration = const Duration(minutes: 25);
  bool _isStrictMode = false;

  String get _formattedTime {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = _focusDuration.inHours;
    final minutes = _focusDuration.inMinutes.remainder(60);
    final seconds = _focusDuration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  void _showTimerPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        final colorScheme = Theme.of(context).colorScheme;
        return Container(
          height: 360,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHigh,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      pickerTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: colorScheme.onSurface,
                            fontSize: 22,
                          ),
                    ),
                  ),
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hms,
                    initialTimerDuration: _focusDuration,
                    onTimerDurationChanged: (Duration newDuration) {
                      setState(() {
                        _focusDuration = newDuration;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Confirm Time'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: AppBar(
          title: const Text('TIMER'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: Stack(
        children: [
          // Background Glow
          Center(
            child: Container(
              width: 1,
              height: 1,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withValues(alpha: 0.08),
                    blurRadius: 150,
                    spreadRadius: 250,
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  // Timer Display
                  const SizedBox(height: 60),
                  GestureDetector(
                    onTap: () => _showTimerPicker(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          _formattedTime,
                          style: textTheme.displayLarge?.copyWith(
                            shadows: [
                              Shadow(
                                color: colorScheme.primary.withValues(alpha: 0.15),
                                blurRadius: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  // Input Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextField(
                      cursorColor: colorScheme.primary,
                      style: textTheme.bodyLarge,
                      decoration: const InputDecoration(
                        hintText: 'What are you focusing on?',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Horizontal Tags
                  SizedBox(
                    height: 48,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      clipBehavior: Clip.none,
                      children: [
                        _buildTag(
                          context,
                          'Coding',
                          isSelected: true,
                        ),
                        const SizedBox(width: 12),
                        _buildTag(context, 'Studying'),
                        const SizedBox(width: 12),
                        _buildTag(
                          context,
                          'Deep Work',
                          isTertiary: true,
                        ),
                        const SizedBox(width: 12),
                        _buildTag(context, 'Meditating'),
                        const SizedBox(width: 12),
                        _buildTag(context, 'Reading'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Start Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {},
                        child: const Text('Start Focus'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Strict Mode Toggle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: colorScheme.outlineVariant.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Strict Mode',
                                style: textTheme.titleMedium?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'DISABLE APP SWITCHING',
                                style: textTheme.labelSmall?.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.5,
                                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: _isStrictMode,
                            onChanged: (value) {
                              setState(() {
                                _isStrictMode = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(
    BuildContext context,
    String label, {
    bool isSelected = false,
    bool isTertiary = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color bgColor = colorScheme.surfaceContainerHigh;
    Color textColor = colorScheme.onSurfaceVariant;
    BorderSide borderSide = BorderSide(
      color: colorScheme.outlineVariant.withValues(alpha: 0.1),
    );

    if (isSelected) {
      bgColor = colorScheme.secondaryContainer.withValues(alpha: 0.4);
      textColor = colorScheme.onSecondaryContainer;
    } else if (isTertiary) {
      bgColor = colorScheme.tertiaryContainer.withValues(alpha: 0.05);
      textColor = colorScheme.inversePrimary;
      borderSide = BorderSide(
        color: colorScheme.inversePrimary.withValues(alpha: 0.15),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100),
        border: Border.fromBorderSide(borderSide),
      ),
      child: Center(
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: textColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
