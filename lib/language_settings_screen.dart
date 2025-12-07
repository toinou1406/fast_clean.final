import 'package:fastclean/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fastclean/l10n/app_localizations.dart';

class LanguageSettingsScreen extends StatefulWidget {
  final void Function(Locale) onLocaleChanged;

  const LanguageSettingsScreen({super.key, required this.onLocaleChanged});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String _currentLanguageCode = 'en'; // Default language

  @override
  void initState() {
    super.initState();
    _loadCurrentLanguage();
  }

  Future<void> _loadCurrentLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentLanguageCode = prefs.getString('language_code') ?? 'en';
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings, style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.chooseYourLanguage, // Needs to be added to ARB files
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 32),
            _buildLanguageSelector(),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFlag('en', '🇬🇧', _currentLanguageCode == 'en'),
        const SizedBox(width: 24),
        _buildFlag('es', '🇪🇸', _currentLanguageCode == 'es'),
        const SizedBox(width: 24),
        _buildFlag('fr', '🇫🇷', _currentLanguageCode == 'fr'),
        const SizedBox(width: 24),
        _buildFlag('zh', '🇨🇳', _currentLanguageCode == 'zh'),
      ],
    );
  }

  Widget _buildFlag(String languageCode, String flag, bool isSelected) {
    return GestureDetector(
      onTap: () async {
        final newLocale = Locale(languageCode);
        widget.onLocaleChanged(newLocale);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('language_code', languageCode);
        setState(() {
          _currentLanguageCode = languageCode;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: isSelected
            ? BoxDecoration(
                border: Border.all(color: etherealGreen, width: 2),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: Text(
          flag,
          style: const TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
