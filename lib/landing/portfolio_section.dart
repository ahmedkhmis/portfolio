import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/utilities/app_constants.dart';

/// About Me section with profile image, bio, and skill chips.
class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('about_title'.tr(), style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8.0),
        Divider(color: theme.dividerColor, thickness: 1.5),
        const SizedBox(height: 32.0),

        LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;

            return Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image
                Flexible(
                  flex: isMobile ? 0 : 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: isMobile ? 0.0 : 32.0,
                      bottom: isMobile ? 24.0 : 0.0,
                    ),
                    child: Center(
                      child:
                          Container(
                                width: isMobile ? 180.0 : 220.0,
                                height: isMobile ? 180.0 : 220.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    color: AppColors.accent.withAlpha(80),
                                    width: 2.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.accent.withAlpha(30),
                                      blurRadius: 24.0,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(17.0),
                                  child: Image.asset(
                                    AppConstants.profileImageAssetPath,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: theme.cardColor,
                                      child: Icon(
                                        Icons.person,
                                        size: 80.0,
                                        color: theme.iconTheme.color,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .animate()
                              .fadeIn(duration: 600.ms)
                              .scale(
                                begin: const Offset(0.9, 0.9),
                                end: const Offset(1.0, 1.0),
                                duration: 600.ms,
                              ),
                    ),
                  ),
                ),

                // About text + skills
                Flexible(
                  flex: isMobile ? 0 : 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        'about_description'.tr(),
                        style: theme.textTheme.bodyLarge,
                      ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
                      const SizedBox(height: 28.0),

                      Text(
                        'about_skills_title'.tr(),
                        style: theme.textTheme.titleLarge,
                      ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
                      const SizedBox(height: 16.0),

                      _buildSkillCategory(
                        context,
                        label: 'Languages',
                        skills: 'skills_languages'.tr(),
                        icon: Icons.code,
                        isDark: isDark,
                        delay: 400,
                      ),
                      _buildSkillCategory(
                        context,
                        label: 'Frontend',
                        skills: 'skills_frontend'.tr(),
                        icon: Icons.web,
                        isDark: isDark,
                        delay: 500,
                      ),
                      _buildSkillCategory(
                        context,
                        label: 'Backend',
                        skills: 'skills_backend'.tr(),
                        icon: Icons.dns,
                        isDark: isDark,
                        delay: 600,
                      ),
                      _buildSkillCategory(
                        context,
                        label: 'Databases',
                        skills: 'skills_databases'.tr(),
                        icon: Icons.storage,
                        isDark: isDark,
                        delay: 700,
                      ),
                      _buildSkillCategory(
                        context,
                        label: 'Architecture',
                        skills: 'skills_architecture'.tr(),
                        icon: Icons.architecture,
                        isDark: isDark,
                        delay: 800,
                      ),
                      _buildSkillCategory(
                        context,
                        label: 'Tools',
                        skills: 'skills_tools'.tr(),
                        icon: Icons.build,
                        isDark: isDark,
                        delay: 900,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildSkillCategory(
    BuildContext context, {
    required String label,
    required String skills,
    required IconData icon,
    required bool isDark,
    required int delay,
  }) {
    final theme = Theme.of(context);
    final skillList = skills.split(', ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.accent),
              const SizedBox(width: 8),
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: skillList
                .map((skill) => _SkillChip(label: skill.trim(), isDark: isDark))
                .toList(),
          ),
        ],
      ).animate(delay: delay.ms).fadeIn(duration: 400.ms),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  final bool isDark;

  const _SkillChip({required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.accent.withAlpha(20)
            : AppColors.accent.withAlpha(15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.accent.withAlpha(isDark ? 50 : 40)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isDark ? AppColors.accentLight : AppColors.accentDark,
        ),
      ),
    );
  }
}
