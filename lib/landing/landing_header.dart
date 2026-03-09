import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:app/core/cubit/theme_cubit.dart';
import 'package:app/core/cubit/locale_cubit.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/utilities/app_constants.dart';
import 'package:app/utilities/extensions.dart';
import 'package:app/utilities/url_launcher.dart';
import 'package:app/landing/widgets/animated_background_image.dart';
import 'package:app/utilities/diagonal_path_clipper.dart';

class LandingHeader extends StatelessWidget {
  final ScrollController scrollController;

  const LandingHeader(this.scrollController, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DiagonalPathClipper(),
      child: Stack(
        fit: StackFit.loose,
        children: [
          AnimatedBackgroundImage(scrollController),
          Align(alignment: Alignment.center, child: _buildSurface(context)),
          // Top bar with theme & language toggles
          Positioned(top: 16, right: 16, child: _buildTopBar(context)),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final localeCubit = context.read<LocaleCubit>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // Theme toggle
        _ToggleButton(
          icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          tooltip: isDark ? 'theme_light'.tr() : 'theme_dark'.tr(),
          onTap: () => themeCubit.toggleTheme(),
        ),
        // Locale toggle
        _ToggleButton(
          icon: Icons.translate_rounded,
          tooltip: localeCubit.isEnglish ? 'Français' : 'English',
          label: localeCubit.isEnglish ? 'FR' : 'EN',
          onTap: () => localeCubit.toggleLocale(context),
        ),
      ],
    ).animate().fadeIn(delay: 500.ms, duration: 600.ms);
  }

  Widget _buildSurface(BuildContext context) {
    final theme = Theme.of(context);

    final titleSize = ResponsiveValue<double>(
      context,
      defaultValue: 28.0,
      conditionalValues: [
        Condition.equals(name: TABLET, value: 32.0),
        Condition.largerThan(name: TABLET, value: 48.0),
      ],
    ).value;

    final subtitleSize = ResponsiveValue<double>(
      context,
      defaultValue: 14.0,
      conditionalValues: [
        Condition.equals(name: TABLET, value: 15.0),
        Condition.largerThan(name: TABLET, value: 18.0),
      ],
    ).value;

    final maxWidth = ResponsiveValue<double>(
      context,
      defaultValue: 602.0,
      conditionalValues: [
        const Condition.equals(name: TABLET, value: 800.0),
        const Condition.largerThan(name: TABLET, value: 1200.0),
      ],
    ).value;

    final isCentered = !context.isDesktop;

    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: const EdgeInsets.symmetric(vertical: 96.0, horizontal: 24.0),
      child: Column(
        crossAxisAlignment: isCentered
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          // Profile image + Name row
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.accent.withAlpha(120),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withAlpha(40),
                      blurRadius: 20,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    AppConstants.profileImageAssetPath,
                    height: context.isMobile ? 56 : 72,
                    width: context.isMobile ? 56 : 72,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 72,
                      width: 72,
                      color: AppColors.darkCard,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                ),
              ).animate().scale(
                delay: 400.ms,
                duration: 600.ms,
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
                curve: Curves.elasticOut,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child:
                    SelectableText(
                          AppConstants.landingTitle,
                          style: TextStyle(
                            fontSize: titleSize,
                            fontWeight: FontWeight.w800,
                            color: theme.textTheme.displayLarge?.color,
                            letterSpacing: 3.0,
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 600.ms, duration: 600.ms)
                        .slideX(begin: 0.1, end: 0),
              ),
            ],
          ),
          const SizedBox(height: 22.0),

          // Divider
          Divider(
            thickness: 1.75,
            color: theme.dividerColor,
          ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
          const SizedBox(height: 24.0),

          // Subtitle / Motto
          SelectableText(
            'hero_subtitle'.tr().toUpperCase(),
            textAlign: isCentered ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: subtitleSize,
              fontWeight: FontWeight.w400,
              color: AppColors.accent,
              letterSpacing: 2.5,
            ),
          ).animate().fadeIn(delay: 1000.ms, duration: 500.ms),
          const SizedBox(height: 40.0),

          // Social Media Buttons
          Container(
            alignment: isCentered ? Alignment.center : null,
            child: Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              alignment: isCentered
                  ? WrapAlignment.center
                  : WrapAlignment.start,
              children: [
                _SocialIcon(
                  icon: FontAwesomeIcons.github,
                  url: AppConstants.gitHubProfileURL,
                  index: 0,
                ),
                _SocialIcon(
                  icon: FontAwesomeIcons.linkedin,
                  url: AppConstants.linkedInProfileURL,
                  index: 1,
                ),
                _SocialIcon(
                  icon: Icons.email_rounded,
                  url: AppConstants.eMail,
                  index: 2,
                ),
                _SocialIcon(
                  icon: Icons.phone_rounded,
                  url: AppConstants.phone,
                  index: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Helper Widgets ─────────────────────────────────────────────────

class _ToggleButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final String? label;
  final VoidCallback onTap;

  const _ToggleButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.label,
  });

  @override
  State<_ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<_ToggleButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _hovered
                  ? AppColors.accent.withAlpha(50)
                  : (isDark
                        ? Colors.white.withAlpha(15)
                        : Colors.black.withAlpha(15)),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _hovered
                    ? AppColors.accent.withAlpha(100)
                    : Colors.transparent,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon,
                  size: 18,
                  color: _hovered
                      ? AppColors.accent
                      : (isDark ? Colors.white : Colors.black87),
                ),
                if (widget.label != null) ...[
                  const SizedBox(width: 6),
                  Text(
                    widget.label!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _hovered
                          ? AppColors.accent
                          : (isDark ? Colors.white : Colors.black87),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final int index;

  const _SocialIcon({
    required this.icon,
    required this.url,
    required this.index,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
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
            onTap: () => launchUrl(widget.url),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _hovered
                    ? AppColors.accent.withAlpha(40)
                    : (isDark?Colors.black:Colors.white).withAlpha(15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _hovered
                      ? AppColors.accent.withAlpha(100)
                      : (isDark?Colors.white:Colors.black).withAlpha(20),
                ),
              ),
              child: Icon(
                widget.icon,
                color: _hovered ? AppColors.accent : (isDark?Colors.white:Colors.black),
                size: 22,
              ),
            ),
          ),
        )
        .animate(delay: (1100 + (widget.index * 100)).ms)
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.3, end: 0);
  }
}
