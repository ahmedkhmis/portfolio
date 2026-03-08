import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:app/core/theme/app_colors.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'education_title'.tr(),
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 8.0),
        Divider(color: theme.dividerColor, thickness: 1.5),
        const SizedBox(height: 24.0),
        ...List.generate(3, (i) {
          final idx = i + 1;
          return _buildEducationCard(
            context,
            degree: 'edu_${idx}_degree'.tr(),
            specialization: 'edu_${idx}_specialization'.tr(),
            school: 'edu_${idx}_school'.tr(),
            date: 'edu_${idx}_date'.tr(),
            isDark: isDark,
            index: i,
          );
        }),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildEducationCard(
    BuildContext context, {
    required String degree,
    required String specialization,
    required String school,
    required String date,
    required bool isDark,
    required int index,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: AppColors.accentGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.school,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(degree,
                      style: theme.textTheme.titleLarge?.copyWith(fontSize: 17)),
                  if (specialization.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(specialization,
                        style: theme.textTheme.bodyLarge?.copyWith(fontSize: 14)),
                  ],
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 14,
                          color: theme.textTheme.bodyMedium?.color),
                      const SizedBox(width: 4),
                      Text(school,
                          style:
                              theme.textTheme.bodyMedium?.copyWith(fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 14,
                          color: theme.textTheme.bodyMedium?.color),
                      const SizedBox(width: 4),
                      Text(date,
                          style:
                              theme.textTheme.labelLarge?.copyWith(fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate(delay: (200 * index).ms).fadeIn(duration: 400.ms).slideX(begin: 0.05, end: 0),
    );
  }
}
