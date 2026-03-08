import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/utilities/showcase_app_model.dart';
import 'package:app/utilities/url_launcher.dart';

/// Detail page for a single project.
class ProjectDetailScreen extends StatelessWidget {
  final ShowcaseAppModel app;

  const ProjectDetailScreen({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // ── Collapsing header with logo ──
          SliverAppBar(
            expandedHeight: isMobile ? 260.0 : 320.0,
            pinned: true,
            backgroundColor: isDark
                ? AppColors.darkSurface
                : AppColors.lightPrimary,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: isDark
                    ? Colors.black.withAlpha(80)
                    : Colors.white.withAlpha(180),
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: theme.iconTheme.color,
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _HeroBanner(app: app, isDark: isDark),
            ),
          ),

          // ── Body content ──
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 900),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20.0 : 40.0,
                  vertical: 32.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                          app.name,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slideX(begin: -0.05, end: 0),
                    const SizedBox(height: 12),

                    // Topic badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.accent.withAlpha(30),
                            AppColors.accentDark.withAlpha(20),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.accent.withAlpha(60),
                        ),
                      ),
                      child: Text(
                        app.topic,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accent,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
                    const SizedBox(height: 24),

                    // Description
                    SelectableText(
                      app.description,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        height: 1.7,
                        fontSize: 16,
                      ),
                    ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
                    const SizedBox(height: 28),

                    // Tech stack
                    if (app.techStack.isNotEmpty) ...[
                      Text(
                        'Tech Stack',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: app.techStack.asMap().entries.map((entry) {
                          return _TechChip(
                            label: entry.value,
                            isDark: isDark,
                            delay: 350 + entry.key * 50,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 28),
                    ],

                    // External links
                    if (app.githubURL != null ||
                        app.playStoreURL != null ||
                        app.appStoreURL != null) ...[
                      Divider(color: theme.dividerColor, height: 1),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          if (app.githubURL != null)
                            _ExternalLinkButton(
                              icon: FontAwesomeIcons.github,
                              label: 'GitHub',
                              url: app.githubURL!,
                              isDark: isDark,
                            ),
                          if (app.playStoreURL != null)
                            _ExternalLinkButton(
                              icon: FontAwesomeIcons.googlePlay,
                              label: 'Play Store',
                              url: app.playStoreURL!,
                              isDark: isDark,
                            ),
                          if (app.appStoreURL != null)
                            _ExternalLinkButton(
                              icon: FontAwesomeIcons.apple,
                              label: 'App Store',
                              url: app.appStoreURL!,
                              isDark: isDark,
                            ),
                        ],
                      ).animate().fadeIn(delay: 400.ms, duration: 500.ms),
                      const SizedBox(height: 28),
                    ],

                    // ── Screenshots gallery ──
                    if (app.screenshots.isNotEmpty) ...[
                      Divider(color: theme.dividerColor, height: 1),
                      const SizedBox(height: 24),
                      Text(
                        'Screenshots',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: isMobile ? 280 : 420,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: app.screenshots.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            return _ScreenshotCard(
                              imagePath: app.screenshots[index],
                              index: index,
                              isDark: isDark,
                              height: isMobile ? 280 : 420,
                              allScreenshots: app.screenshots,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Hero banner with gradient + logo ────────────────────────────────

class _HeroBanner extends StatelessWidget {
  final ShowcaseAppModel app;
  final bool isDark;

  const _HeroBanner({required this.app, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  const Color(0xFF1A1A3E),
                  const Color(0xFF2A2A58),
                  AppColors.accent.withAlpha(40),
                ]
              : [
                  const Color(0xFFE8E8F4),
                  const Color(0xFFD8D8F0),
                  AppColors.accent.withAlpha(30),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withAlpha(isDark ? 15 : 20),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withAlpha(isDark ? 10 : 15),
              ),
            ),
          ),

          // Logo / icon
          Center(child: _buildLogo()),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    if (app.image != null) {
      return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withAlpha(40),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                app.image!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildIconFallback(),
              ),
            ),
          )
          .animate()
          .fadeIn(duration: 600.ms)
          .scale(
            begin: const Offset(0.85, 0.85),
            end: const Offset(1.0, 1.0),
            duration: 600.ms,
            curve: Curves.easeOutBack,
          );
    }
    return _buildIconFallback()
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(
          begin: const Offset(0.85, 0.85),
          end: const Offset(1.0, 1.0),
          duration: 600.ms,
          curve: Curves.easeOutBack,
        );
  }

  Widget _buildIconFallback() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.accent.withAlpha(25),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.accent.withAlpha(60)),
      ),
      child: Icon(
        app.icon ?? Icons.apps_rounded,
        size: 48,
        color: AppColors.accent,
      ),
    );
  }
}

// ─── Tech chip ───────────────────────────────────────────────────────

class _TechChip extends StatelessWidget {
  final String label;
  final bool isDark;
  final int delay;

  const _TechChip({
    required this.label,
    required this.isDark,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.accent.withAlpha(18)
                : AppColors.accent.withAlpha(12),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.accent.withAlpha(isDark ? 50 : 40),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.accentLight : AppColors.accentDark,
            ),
          ),
        )
        .animate(delay: delay.ms)
        .fadeIn(duration: 350.ms)
        .slideX(begin: 0.05, end: 0);
  }
}

// ─── External link button ────────────────────────────────────────────

class _ExternalLinkButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final bool isDark;

  const _ExternalLinkButton({
    required this.icon,
    required this.label,
    required this.url,
    required this.isDark,
  });

  @override
  State<_ExternalLinkButton> createState() => _ExternalLinkButtonState();
}

class _ExternalLinkButtonState extends State<_ExternalLinkButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.accent.withAlpha(25)
                : (widget.isDark
                      ? Colors.white.withAlpha(8)
                      : Colors.black.withAlpha(8)),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withAlpha(80)
                  : (widget.isDark
                        ? Colors.white.withAlpha(15)
                        : Colors.black.withAlpha(15)),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: _hovered
                    ? AppColors.accent
                    : Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _hovered
                      ? AppColors.accent
                      : Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Screenshot card ─────────────────────────────────────────────────

class _ScreenshotCard extends StatefulWidget {
  final String imagePath;
  final int index;
  final bool isDark;
  final double height;
  final List<String> allScreenshots;

  const _ScreenshotCard({
    required this.imagePath,
    required this.index,
    required this.isDark,
    required this.height,
    required this.allScreenshots,
  });

  @override
  State<_ScreenshotCard> createState() => _ScreenshotCardState();
}

class _ScreenshotCardState extends State<_ScreenshotCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: () => _openViewer(context, widget.index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: widget.height * 0.55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: _hovered
                      ? AppColors.accent.withAlpha(100)
                      : (widget.isDark
                            ? Colors.white.withAlpha(10)
                            : Colors.black.withAlpha(10)),
                  width: _hovered ? 2 : 1,
                ),
                boxShadow: _hovered
                    ? [
                        BoxShadow(
                          color: AppColors.accent.withAlpha(30),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withAlpha(
                            widget.isDark ? 40 : 15,
                          ),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: AnimatedScale(
                  scale: _hovered ? 1.03 : 1.0,
                  duration: const Duration(milliseconds: 250),
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                    height: widget.height,
                    errorBuilder: (_, __, ___) => Container(
                      color: widget.isDark
                          ? const Color(0xFF1E1E3A)
                          : const Color(0xFFE0E0F0),
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
        .animate(delay: (100 * widget.index).ms)
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.08, end: 0);
  }

  void _openViewer(BuildContext context, int startIndex) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => _ScreenshotViewer(
        screenshots: widget.allScreenshots,
        initialIndex: startIndex,
      ),
    );
  }
}

// ─── Full-screen screenshot viewer ───────────────────────────────────

class _ScreenshotViewer extends StatefulWidget {
  final List<String> screenshots;
  final int initialIndex;

  const _ScreenshotViewer({
    required this.screenshots,
    required this.initialIndex,
  });

  @override
  State<_ScreenshotViewer> createState() => _ScreenshotViewerState();
}

class _ScreenshotViewerState extends State<_ScreenshotViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Page view
        PageView.builder(
          controller: _pageController,
          itemCount: widget.screenshots.length,
          onPageChanged: (i) => setState(() => _currentIndex = i),
          itemBuilder: (context, index) {
            return InteractiveViewer(
              minScale: 0.5,
              maxScale: 3.0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      widget.screenshots[index],
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.broken_image,
                        size: 64,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        // Close button
        Positioned(
          top: 16,
          right: 16,
          child: Material(
            color: Colors.white.withAlpha(20),
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Navigator.of(context).pop(),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.close, color: Colors.white, size: 24),
              ),
            ),
          ),
        ),

        // Counter indicator
        Positioned(
          bottom: 24,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_currentIndex + 1} / ${widget.screenshots.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),

        // Left arrow
        if (_currentIndex > 0)
          Positioned(
            left: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: _NavArrow(
                icon: Icons.chevron_left_rounded,
                onTap: () => _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
          ),

        // Right arrow
        if (_currentIndex < widget.screenshots.length - 1)
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: _NavArrow(
                icon: Icons.chevron_right_rounded,
                onTap: () => _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _NavArrow extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavArrow({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withAlpha(20),
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(icon, color: Colors.white, size: 32),
        ),
      ),
    );
  }
}
