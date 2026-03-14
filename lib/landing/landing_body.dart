import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:app/landing/portfolio_section.dart';
import 'package:app/landing/experience_section.dart';
import 'package:app/landing/education_section.dart';
import 'package:app/landing/resume_section.dart';
import 'package:app/landing/contact_section.dart';
import 'package:app/landing/landing_footer.dart';
import 'package:app/landing/widgets/showcase_app_item.dart';
import 'package:app/utilities/showcase_app_model.dart';
import 'package:app/utilities/extensions.dart';

class LandingBody extends StatelessWidget {
  final GlobalKey aboutKey;
  final GlobalKey experienceKey;
  final GlobalKey educationKey;
  final GlobalKey projectsKey;
  final GlobalKey resumeKey;
  final GlobalKey contactKey;

  const LandingBody({
    super.key,
    required this.aboutKey,
    required this.experienceKey,
    required this.educationKey,
    required this.projectsKey,
    required this.resumeKey,
    required this.contactKey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200.0),
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── About Me ──
          PortfolioSection(key: aboutKey),
          const SizedBox(height: 80.0),

          // ── Professional Experience ──
          ExperienceSection(key: experienceKey),
          const SizedBox(height: 80.0),

          // ── Education ──
          EducationSection(key: educationKey),
          const SizedBox(height: 80.0),

          // ── Professional Projects ──
          Text(
            'projects_title'.tr(),
            key: projectsKey,
            style: theme.textTheme.headlineMedium,
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 8),
          Text(
            'projects_subtitle'.tr(),
            style: theme.textTheme.bodyLarge,
          ).animate().fadeIn(delay: 100.ms, duration: 500.ms),
          const SizedBox(height: 8),
          Divider(
            color: theme.dividerColor,
            thickness: 1.5,
          ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
          const SizedBox(height: 24),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: professionalApps.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.isDesktop
                  ? 3
                  : context.isTablet
                  ? 2
                  : 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 380,
            ),
            itemBuilder: (context, i) {
              return ShowcaseAppItem(professionalApps[i], index: i);
            },
          ),
          const SizedBox(height: 60.0),

          // ── Academic Projects ──
          Text(
            'academic_projects_title'.tr(),
            style: theme.textTheme.headlineMedium,
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 8),
          Divider(
            color: theme.dividerColor,
            thickness: 1.5,
          ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
          const SizedBox(height: 24),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: academicApps.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.isDesktop
                  ? 4
                  : context.isTablet
                  ? 2
                  : 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 400, // Increased to avoid overflow
            ),
            itemBuilder: (context, i) {
              return ShowcaseAppItem(
                academicApps[i],
                useIcon: true,
                index: i + professionalApps.length,
              );
            },
          ),
          const SizedBox(height: 80.0),

          // ── Resume Downloads ──
          ResumeSection(key: resumeKey),
          const SizedBox(height: 80.0),

          // ── Contact ──
          ContactSection(key: contactKey),
          const SizedBox(height: 80.0),

          // ── Footer ──
          const LandingFooter(),
          const SizedBox(height: 60.0),
        ],
      ),
    );
  }
}
