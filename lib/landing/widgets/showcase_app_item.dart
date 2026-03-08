import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/utilities/showcase_app_model.dart';
import 'package:app/utilities/url_launcher.dart';
import 'package:app/project/project_detail_screen.dart';

/// A project card with gradient placeholder image, tech stack tags, and links.
class ShowcaseAppItem extends StatefulWidget {
  final ShowcaseAppModel app;
  final int index;
  final bool useIcon;

  const ShowcaseAppItem(
    this.app, {
    super.key,
    this.index = 0,
    this.useIcon = false,
  });

  @override
  State<ShowcaseAppItem> createState() => _ShowcaseAppItemState();
}

class _ShowcaseAppItemState extends State<ShowcaseAppItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProjectDetailScreen(app: widget.app),
              ),
            );
          },
          child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: SizedBox.expand(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: _hovered
                      ? AppColors.accent.withAlpha(100)
                      : isDark
                      ? Colors.white.withAlpha(8)
                      : Colors.black.withAlpha(8),
                  width: _hovered ? 1.5 : 1.0,
                ),
                boxShadow: _hovered
                    ? [
                        BoxShadow(
                          color: AppColors.accent.withAlpha(25),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withAlpha(isDark ? 40 : 15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Gradient placeholder image ──
                    widget.useIcon
                        ? _buildPlaceholderIcon(isDark)
                        : _buildPlaceholderImage(isDark),

                    // ── Content ──
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // App name
                              Text(
                                widget.app.name,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontSize: 16,
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),

                              // Topic badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.accent.withAlpha(25),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  widget.app.topic,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.accent,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Description
                              Text(
                                widget.app.description,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 13,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 12),

                              // Tech stack chips
                              if (widget.app.techStack.isNotEmpty)
                                Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  children: widget.app.techStack.map((tech) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 7,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? Colors.white.withAlpha(8)
                                            : Colors.black.withAlpha(8),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        tech,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              theme.textTheme.bodyMedium?.color,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Links row (Pinned outside scroll if we want, or inside?)
                    // Let's put links OUTSIDE the scrollable so they stay at the bottom.
                    if (widget.app.githubURL != null ||
                        widget.app.playStoreURL != null ||
                        widget.app.appStoreURL != null) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(color: theme.dividerColor, height: 1),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                if (widget.app.githubURL != null)
                                  _LinkIcon(
                                    icon: FontAwesomeIcons.github,
                                    url: widget.app.githubURL!,
                                    label: 'Github',
                                  ),
                                if (widget.app.playStoreURL != null)
                                  _LinkIcon(
                                    icon: FontAwesomeIcons.googlePlay,
                                    url: widget.app.playStoreURL!,
                                    label: 'Play Store',
                                  ),
                                if (widget.app.appStoreURL != null)
                                  _LinkIcon(
                                    icon: FontAwesomeIcons.apple,
                                    url: widget.app.appStoreURL!,
                                    label: 'App Store',
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        )
        .animate(delay: (100 * widget.index).ms)
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.08, end: 0);
  }

  /// Gradient placeholder with icon — easy to swap for Image.asset later.
  Widget _buildPlaceholderImage(bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _hovered
              ? [
                  AppColors.accent.withAlpha(60),
                  AppColors.accentDark.withAlpha(40),
                ]
              : isDark
              ? [const Color(0xFF1E1E3A), const Color(0xFF2A2A50)]
              : [const Color(0xFFE0E0F0), const Color(0xFFD0D0E8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: AnimatedScale(
          scale: _hovered ? 1.15 : 1.0,
          duration: const Duration(milliseconds: 250),
          child: Image.asset(widget.app.image!, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildPlaceholderIcon(bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _hovered
              ? [
                  AppColors.accent.withAlpha(60),
                  AppColors.accentDark.withAlpha(40),
                ]
              : isDark
              ? [const Color(0xFF1E1E3A), const Color(0xFF2A2A50)]
              : [const Color(0xFFE0E0F0), const Color(0xFFD0D0E8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: AnimatedScale(
          scale: _hovered ? 1.15 : 1.0,
          duration: const Duration(milliseconds: 250),
          child: Icon(
            widget.app.icon!,
            size: 48,
            color: _hovered
                ? AppColors.accent
                : (isDark
                      ? Colors.white.withAlpha(40)
                      : Colors.black.withAlpha(30)),
          ),
        ),
      ),
    );
  }
}

class _LinkIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final String? label;

  const _LinkIcon({required this.icon, required this.url, this.label});

  @override
  State<_LinkIcon> createState() => _LinkIconState();
}

class _LinkIconState extends State<_LinkIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: Tooltip(
          message: widget.label ?? '',
          child: GestureDetector(
            onTap: () => launchUrl(widget.url),
            child: Icon(
              widget.icon,
              size: 18,
              color: _hovered
                  ? AppColors.accent
                  : Theme.of(context).iconTheme.color,
            ),
          ),
        ),
      ),
    );
  }
}
