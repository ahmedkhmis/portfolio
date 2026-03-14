import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:app/core/cubit/theme_cubit.dart';
import 'package:app/landing/landing_header.dart';
import 'package:app/landing/landing_body.dart';
import 'package:app/landing/widgets/scroll_up_indicator.dart';
import 'package:app/landing/widgets/landing_navigation_bar.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late final ScrollController _scrollController;

  // Keys for section scrolling
  late final GlobalKey _aboutKey;
  late final GlobalKey _experienceKey;
  late final GlobalKey _educationKey;
  late final GlobalKey _projectsKey;
  late final GlobalKey _resumeKey;
  late final GlobalKey _contactKey;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _aboutKey = GlobalKey();
    _experienceKey = GlobalKey();
    _educationKey = GlobalKey();
    _projectsKey = GlobalKey();
    _resumeKey = GlobalKey();
    _contactKey = GlobalKey();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          drawer: _buildDrawer(context),
          body: Stack(
            children: [
              Scrollbar(
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      LandingHeader(_scrollController),
                      const SizedBox(height: 56.0),
                      LandingBody(
                        aboutKey: _aboutKey,
                        experienceKey: _experienceKey,
                        educationKey: _educationKey,
                        projectsKey: _projectsKey,
                        resumeKey: _resumeKey,
                        contactKey: _contactKey,
                      ),
                    ],
                  ),
                ),
              ),
              LandingNavigationBar(
                scrollController: _scrollController,
                aboutKey: _aboutKey,
                experienceKey: _experienceKey,
                educationKey: _educationKey,
                projectsKey: _projectsKey,
                resumeKey: _resumeKey,
                contactKey: _contactKey,
              ),
              ScrollUpIndicator(_scrollController),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.primaryColor.withAlpha(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ahmed Khmis',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  'Software Engineer',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          _DrawerItem(
            label: 'nav_about'.tr(),
            icon: Icons.person_outline,
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(_aboutKey);
            },
          ),
          _DrawerItem(
            label: 'nav_experience'.tr(),
            icon: Icons.work_outline,
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(_experienceKey);
            },
          ),
          _DrawerItem(
            label: 'nav_education'.tr(),
            icon: Icons.school_outlined,
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(_educationKey);
            },
          ),
          _DrawerItem(
            label: 'nav_projects'.tr(),
            icon: Icons.code_rounded,
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(_projectsKey);
            },
          ),
          _DrawerItem(
            label: 'nav_resume'.tr(),
            icon: Icons.description_outlined,
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(_resumeKey);
            },
          ),
          _DrawerItem(
            label: 'nav_contact'.tr(),
            icon: Icons.mail_outline,
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(_contactKey);
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(label),
      onTap: onTap,
    );
  }
}
