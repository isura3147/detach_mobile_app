import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({super.key});

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
          title: Text(
            'HISTORY',
            style: textTheme.labelSmall?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
      ),
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
              currentIndex: 2,
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCalendarSection(context),
              const SizedBox(height: 64),
              _buildSummarySection(context),
              const SizedBox(height: 120), // Bottom padding for nav bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'October',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  color: colorScheme.onSurfaceVariant,
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  color: colorScheme.onSurfaceVariant,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 32),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.0, // To make them square
          mainAxisSpacing: 16, // match gap-y-8 spacing feeling
          children: [
            // Weekdays
            ...['S', 'M', 'T', 'W', 'T', 'F', 'S'].map(
              (day) => Center(
                child: Text(
                  day,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            // Days
            // Previous month
            ...List.generate(7, (i) => _buildCalendarDay(context, (24 + i).toString(), isMuted: true)),
            // Current month (up to 21 for this visual)
            ...List.generate(21, (i) {
              int day = i + 1;
              bool isSelected = day == 10;
              List<Color> dots = [];
              if (day == 1 || day == 5 || day == 12) dots.add(AppColors.secondary);
              if (day == 3 || day == 9) dots.add(AppColors.tertiaryDim);
              if (isSelected) {
                dots.add(AppColors.secondary);
                dots.add(AppColors.tertiaryDim);
              }
              return _buildCalendarDay(context, day.toString(), isSelected: isSelected, dots: dots);
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarDay(
    BuildContext context,
    String day, {
    bool isMuted = false,
    bool isSelected = false,
    List<Color> dots = const [],
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: isSelected
              ? BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                )
              : null,
          alignment: Alignment.center,
          child: Text(
            day,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w300,
              color: isSelected
                  ? colorScheme.primary
                  : isMuted
                      ? colorScheme.onSurfaceVariant.withValues(alpha: 0.2)
                      : colorScheme.onSurface,
            ),
          ),
        ),
        if (dots.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: dots.map((color) => Container(
                width: 4,
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              )).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TUESDAY, OCT 10',
                style: theme.textTheme.labelSmall?.copyWith(
                  letterSpacing: 2.0,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '3 sessions, 2h 15m total',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        _buildSessionCard(
          context: context,
          tag: 'Focus',
          title: 'Deep Work Block',
          time: '9:00 AM',
          duration: '90m session',
          description: 'Completed technical documentation for the new API. Phone was placed in the other room. Very productive.',
          tagColor: AppColors.secondary,
        ),
        _buildSessionCard(
          context: context,
          tag: 'Energy',
          title: 'Creative Morning',
          time: '11:30 AM',
          duration: '30m session',
          description: 'Mood board and conceptual sketching. Felt slightly distracted but managed to finish the primary drafts.',
          tagColor: AppColors.tertiaryDim,
        ),
        _buildSessionCard(
          context: context,
          tag: 'Focus',
          title: 'Evening Review',
          time: '4:45 PM',
          duration: '15m session',
          description: 'Inbox zero and planning for tomorrow.',
          tagColor: AppColors.secondary,
        ),
      ],
    );
  }

  Widget _buildSessionCard({
    required BuildContext context,
    required String tag,
    required String title,
    required String time,
    required String duration,
    required String description,
    required Color tagColor,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final tagBgColor = tagColor.withValues(alpha: 0.1);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: tagBgColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tag.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: tagColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                time,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.timer_outlined,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                duration,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w300,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
