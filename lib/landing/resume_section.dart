import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/utilities/app_constants.dart';
import 'package:app/utilities/url_launcher.dart' as app_launcher;

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'resume_title'.tr(),
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 8.0),
        Text(
          'resume_subtitle'.tr(),
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 8.0),
        Divider(color: theme.dividerColor, thickness: 1.5),
        const SizedBox(height: 24.0),
        LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            final crossAxisCount = isMobile ? 1 : 2;
            final childAspectRatio = isMobile ? 2.8 : 2.5;

            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: childAspectRatio,
              children: [
                _ResumeCard(
                  title: 'resume_en_full'.tr(),
                  lang: 'EN',
                  icon: Icons.description,
                  assetPath: AppConstants.resumeEnFull,
                  index: 0,
                ),
                _ResumeCard(
                  title: 'resume_en_one'.tr(),
                  lang: 'EN',
                  icon: Icons.article,
                  assetPath: AppConstants.resumeEnOne,
                  index: 1,
                ),
                _ResumeCard(
                  title: 'resume_fr_full'.tr(),
                  lang: 'FR',
                  icon: Icons.description,
                  assetPath: AppConstants.resumeFrFull,
                  index: 2,
                ),
                _ResumeCard(
                  title: 'resume_fr_one'.tr(),
                  lang: 'FR',
                  icon: Icons.article,
                  assetPath: AppConstants.resumeFrOne,
                  index: 3,
                ),
              ],
            );
          },
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }
}

class _ResumeCard extends StatefulWidget {
  final String title;
  final String lang;
  final IconData icon;
  final String assetPath;
  final int index;

  const _ResumeCard({
    required this.title,
    required this.lang,
    required this.icon,
    required this.assetPath,
    required this.index,
  });

  @override
  State<_ResumeCard> createState() => _ResumeCardState();
}

class _ResumeCardState extends State<_ResumeCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => app_launcher.launchUrl(widget.assetPath),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.accent.withAlpha(30)
                : theme.cardColor,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withAlpha(120)
                  : isDark
                      ? Colors.white.withAlpha(10)
                      : Colors.black.withAlpha(10),
              width: _hovered ? 1.5 : 1.0,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.accent.withAlpha(40),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: AppColors.accentGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(widget.icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withAlpha(30),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.lang,
                        style: const TextStyle(
                          color: AppColors.accent,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedRotation(
                turns: _hovered ? 0.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.download_rounded,
                  color: _hovered
                      ? AppColors.accent
                      : theme.iconTheme.color,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate(delay: (150 * widget.index).ms).fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }
}
