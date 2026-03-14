import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:app/core/theme/app_colors.dart';

class LandingNavigationBar extends StatefulWidget {
  final ScrollController scrollController;
  final GlobalKey aboutKey;
  final GlobalKey experienceKey;
  final GlobalKey educationKey;
  final GlobalKey projectsKey;
  final GlobalKey resumeKey;
  final GlobalKey contactKey;

  const LandingNavigationBar({
    super.key,
    required this.scrollController,
    required this.aboutKey,
    required this.experienceKey,
    required this.educationKey,
    required this.projectsKey,
    required this.resumeKey,
    required this.contactKey,
  });

  @override
  State<LandingNavigationBar> createState() => _LandingNavigationBarState();
}

class _LandingNavigationBarState extends State<LandingNavigationBar> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    // Nav bar is always visible now as requested.
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final showMenu = screenWidth < 1000;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      top: showMenu ? 10 : (_isVisible ? 20 : -100),
      left: 0,
      right: 0,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: (isDark ? Colors.black : Colors.white).withAlpha(150),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: (isDark ? Colors.white : Colors.black).withAlpha(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(isDark ? 50 : 20),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: showMenu
                  ? InkWell(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: const Icon(Icons.menu_rounded),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _NavButton(
                          label: 'nav_about'.tr(),
                          onTap: () => _scrollToSection(widget.aboutKey),
                        ),
                        _NavButton(
                          label: 'nav_experience'.tr(),
                          onTap: () => _scrollToSection(widget.experienceKey),
                        ),
                        _NavButton(
                          label: 'nav_education'.tr(),
                          onTap: () => _scrollToSection(widget.educationKey),
                        ),
                        _NavButton(
                          label: 'nav_projects'.tr(),
                          onTap: () => _scrollToSection(widget.projectsKey),
                        ),
                        _NavButton(
                          label: 'nav_resume'.tr(),
                          onTap: () => _scrollToSection(widget.resumeKey),
                        ),
                        _NavButton(
                          label: 'nav_contact'.tr(),
                          onTap: () => _scrollToSection(widget.contactKey),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavButton({required this.label, required this.onTap});

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 14,
              fontWeight: _isHovered ? FontWeight.w700 : FontWeight.w500,
              color: _isHovered
                  ? AppColors.accent
                  : (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black87),
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
