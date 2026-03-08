import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

/// Manages the application locale (EN / FR).
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en'));

  void toggleLocale(BuildContext context) {
    final newLocale = state.languageCode == 'en'
        ? const Locale('fr')
        : const Locale('en');
    context.setLocale(newLocale);
    emit(newLocale);
  }

  bool get isEnglish => state.languageCode == 'en';
}
