import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ShieldScreen extends StatelessWidget {
  const ShieldScreen({super.key});

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
            'SHIELD',
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(context),
              const SizedBox(height: 32),
              
              _buildSectionHeader(
                context, 
                'BLOCKED LIST',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.errorContainer,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    '3 ACTIVE',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.onErrorContainer,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildAppCard(
                context: context,
                icon: Icons.social_distance,
                name: 'Instagram',
                category: 'Social Media',
                actionType: _ActionType.allowPrimary,
              ),
              const SizedBox(height: 16),
              _buildAppCard(
                context: context,
                icon: Icons.video_library_outlined,
                name: 'YouTube',
                category: 'Entertainment',
                actionType: _ActionType.allowPrimary,
              ),
              const SizedBox(height: 40),

              _buildSectionHeader(context, 'ALWAYS ALLOWED'),
              const SizedBox(height: 16),
              _buildAppCard(
                context: context,
                icon: Icons.mail_outline,
                name: 'Messages',
                category: 'Communication',
                actionType: _ActionType.blockSecondary,
              ),
              const SizedBox(height: 16),
              _buildAppCard(
                context: context,
                icon: Icons.calendar_month_outlined,
                name: 'Calendar',
                category: 'Productivity',
                actionType: _ActionType.blockSecondary,
              ),
              const SizedBox(height: 40),

              _buildSectionHeader(context, 'INSTALLED APPS'),
              const SizedBox(height: 16),
              _buildInlineAppRow(
                context: context,
                icon: Icons.music_note_outlined,
                name: 'Spotify',
              ),
              _buildDivider(context),
              _buildInlineAppRow(
                context: context,
                icon: Icons.shopping_bag_outlined,
                name: 'Amazon',
              ),
              _buildDivider(context),
              _buildInlineAppRow(
                context: context,
                icon: Icons.map_outlined,
                name: 'Google Maps',
              ),
              const SizedBox(height: 120), // Bottom padding for nav bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextField(
      style: theme.textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: 'Search applications...',
        prefixIcon: Icon(
          Icons.search,
          color: colorScheme.onSurfaceVariant,
          size: 20,
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, {Widget? trailing}) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.labelSmall?.copyWith(
            letterSpacing: 2.0,
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        trailing ?? const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildAppCard({
    required BuildContext context,
    required IconData icon,
    required String name,
    required String category,
    required _ActionType actionType,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: colorScheme.onSurfaceVariant,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  category,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          _buildActionButton(context, actionType),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, _ActionType type) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (type == _ActionType.allowPrimary) {
      return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'ALLOW',
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
            color: colorScheme.onPrimary,
          ),
        ),
      );
    } else {
      return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: colorScheme.onSurfaceVariant,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: colorScheme.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
        ),
        child: Text(
          'BLOCK',
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }
  }

  Widget _buildInlineAppRow({
    required BuildContext context,
    required IconData icon,
    required String name,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: colorScheme.onSurfaceVariant,
              size: 16,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    'BLOCK',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 12,
                color: colorScheme.outlineVariant,
                margin: const EdgeInsets.symmetric(horizontal: 4),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    'ALLOW',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.2),
    );
  }
}

enum _ActionType {
  allowPrimary,
  blockSecondary,
}
