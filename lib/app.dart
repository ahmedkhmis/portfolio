import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:app/core/cubit/theme_cubit.dart';
import 'package:app/core/cubit/locale_cubit.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/landing/landing_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LocaleCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ahmed Khmis – Software Engineer',

            // ── Localization ──
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,

            // ── Theme ──
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: themeMode,

            // ── Responsiveness ──
            builder: (context, child) {
              return ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: const [
                  Breakpoint(start: 0, end: 450, name: MOBILE),
                  Breakpoint(start: 451, end: 800, name: TABLET),
                  Breakpoint(start: 801, end: double.infinity, name: DESKTOP),
                ],
              );
            },
            home: const LandingScreen(),
          );
        },
      ),
    );
  }
}
