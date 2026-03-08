import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/utilities/app_constants.dart';
import 'package:app/utilities/url_launcher.dart';

class LandingFooter extends StatelessWidget {
  const LandingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: theme.dividerColor, width: 1),
        ),
      ),
      child: Column(
        children: [
          // Social row
          Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _FooterLink(
                icon: FontAwesomeIcons.github,
                url: AppConstants.gitHubProfileURL,
              ),
              _FooterLink(
                icon: FontAwesomeIcons.linkedin,
                url: AppConstants.linkedInProfileURL,
              ),
              _FooterLink(
                icon: Icons.email_rounded,
                url: AppConstants.eMail,
              ),
              _FooterLink(
                icon: Icons.phone_rounded,
                url: AppConstants.phone,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // "Built with Flutter" badge
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FontAwesomeIcons.flutter,
                size: 16,
                color: const Color(0xFF54C5F8),
              ),
              const SizedBox(width: 8),
              Text(
                'footer_built_with'.tr(),
                style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.darkTextMuted
                      : AppColors.lightTextMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Copyright
          Text(
            'footer_copyright'.tr(),
            style: TextStyle(
              fontSize: 12,
              color: isDark
                  ? AppColors.darkTextMuted
                  : AppColors.lightTextMuted,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }
}

class _FooterLink extends StatefulWidget {
  final IconData icon;
  final String url;

  const _FooterLink({required this.icon, required this.url});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.accent.withAlpha(30)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            widget.icon,
            size: 20,
            color: _hovered
                ? AppColors.accent
                : Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    );
  }
}
