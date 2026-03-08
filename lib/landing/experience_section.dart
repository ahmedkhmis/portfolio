import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:app/core/theme/app_colors.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'experience_title'.tr(),
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 8.0),
        Divider(color: theme.dividerColor, thickness: 1.5),
        const SizedBox(height: 32.0),

        // Responsive timeline using LayoutBuilder
        LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            return _buildTimeline(context, isMobile, isDark);
          },
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildTimeline(BuildContext context, bool isMobile, bool isDark) {
    final experiences = List.generate(10, (i) {
      final idx = i + 1;
      return _ExperienceData(
        role: 'exp_${idx}_role'.tr(),
        company: 'exp_${idx}_company'.tr(),
        location: 'exp_${idx}_location'.tr(),
        date: 'exp_${idx}_date'.tr(),
        desc: 'exp_${idx}_desc'.tr(),
      );
    });

    return Column(
      children: List.generate(experiences.length, (index) {
        final exp = experiences[index];
        return _buildTimelineEntry(
          context,
          exp,
          isMobile,
          isDark,
          isLast: index == experiences.length - 1,
          index: index,
        );
      }),
    );
  }

  Widget _buildTimelineEntry(
    BuildContext context,
    _ExperienceData exp,
    bool isMobile,
    bool isDark, {
    required bool isLast,
    required int index,
  }) {
    final theme = Theme.of(context);

    final dot = Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.accentGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withAlpha(80),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
    );

    final line = isLast
        ? const SizedBox.shrink()
        : Container(
            width: 2,
            height: 40,
            color: theme.dividerColor,
          );

    final card = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isDark
              ? Colors.white.withAlpha(10)
              : Colors.black.withAlpha(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exp.role,
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppColors.accent,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.business, size: 14, color: theme.textTheme.bodyMedium?.color),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${exp.company}  •  ${exp.location}',
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: theme.textTheme.bodyMedium?.color),
              const SizedBox(width: 6),
              Text(
                exp.date,
                style: theme.textTheme.labelLarge?.copyWith(fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            exp.desc,
            style: theme.textTheme.bodyLarge?.copyWith(fontSize: 14),
          ),
        ],
      ),
    ).animate(delay: (100 * index).ms).fadeIn(duration: 400.ms).slideX(
          begin: isMobile ? 0.05 : (index.isEven ? -0.05 : 0.05),
          end: 0,
        );

    if (isMobile) {
      // Mobile: dot on left, card on right.
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(children: [dot, line]),
            const SizedBox(width: 16),
            Expanded(child: card),
          ],
        ),
      );
    }

    // Desktop: two-column centered timeline.
    final isLeft = index.isEven;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: isLeft ? card : const SizedBox.shrink(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [dot, line]),
          ),
          Expanded(
            child: isLeft ? const SizedBox.shrink() : card,
          ),
        ],
      ),
    );
  }
}

class _ExperienceData {
  final String role;
  final String company;
  final String location;
  final String date;
  final String desc;

  const _ExperienceData({
    required this.role,
    required this.company,
    required this.location,
    required this.date,
    required this.desc,
  });
}
